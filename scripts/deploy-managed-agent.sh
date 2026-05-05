#!/usr/bin/env bash
# Deploy a managed agent from its cookbook directory.
# Usage: ./scripts/deploy-managed-agent.sh <agent-slug>
# Example: ./scripts/deploy-managed-agent.sh pitch-agent

set -euo pipefail

AGENT_SLUG="${1:-}"
if [[ -z "$AGENT_SLUG" ]]; then
  echo "Usage: $0 <agent-slug>" >&2
  echo "Available agents:"
  ls managed-agent-cookbooks/ | grep -v README
  exit 1
fi

COOKBOOK_DIR="managed-agent-cookbooks/${AGENT_SLUG}"
if [[ ! -d "$COOKBOOK_DIR" ]]; then
  echo "Error: no cookbook found at ${COOKBOOK_DIR}" >&2
  exit 1
fi

if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
  echo "Error: ANTHROPIC_API_KEY is not set" >&2
  exit 1
fi

API_BASE="https://api.anthropic.com/v1"
ANTHROPIC_VERSION="2023-06-01"
AGENTS_BETA="agents-2025-05-15"

echo "==> Deploying agent: ${AGENT_SLUG}"

# ── Helper: POST to Anthropic API ──────────────────────────────────────────
api_post() {
  local endpoint="$1"
  local body="$2"
  curl -s -X POST "${API_BASE}${endpoint}" \
    -H "x-api-key: ${ANTHROPIC_API_KEY}" \
    -H "anthropic-version: ${ANTHROPIC_VERSION}" \
    -H "anthropic-beta: ${AGENTS_BETA}" \
    -H "content-type: application/json" \
    -d "$body"
}

# ── 1. Create leaf worker agents ───────────────────────────────────────────
SUBAGENT_IDS=()
SUBAGENT_DIR="${COOKBOOK_DIR}/subagents"

if [[ -d "$SUBAGENT_DIR" ]]; then
  for yaml_file in "${SUBAGENT_DIR}"/*.yaml; do
    subagent_name=$(grep '^name:' "$yaml_file" | head -1 | awk '{print $2}')
    system_prompt=$(python3 - <<EOF
import yaml, sys
with open("${yaml_file}") as f:
    d = yaml.safe_load(f)
print(d.get("system_prompt", "").strip())
EOF
)
    model=$(grep '^model:' "$yaml_file" | head -1 | awk '{print $2}')
    tools_write=$(grep -q 'write' "$yaml_file" && echo 'true' || echo 'false')

    echo "  --> Creating subagent: ${subagent_name}"

    if [[ "$tools_write" == "true" ]]; then
      tools_json='{"type":"computer_20241022","display_width_px":1024,"display_height_px":768}'
    else
      tools_json='null'
    fi

    body=$(python3 -c "
import json, sys
d = {
    'name': '${subagent_name}',
    'model': '${model}',
    'system_prompt': '''${system_prompt}''',
}
print(json.dumps(d))
")

    response=$(api_post "/agents" "$body")
    agent_id=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])" 2>/dev/null || true)

    if [[ -z "$agent_id" ]]; then
      echo "    ERROR creating ${subagent_name}: ${response}" >&2
      exit 1
    fi

    echo "    Created: ${agent_id}"
    SUBAGENT_IDS+=("$agent_id")
  done
fi

# ── 2. Create orchestrator agent ───────────────────────────────────────────
echo "  --> Creating orchestrator: ${AGENT_SLUG}"

orchestrator_yaml="${COOKBOOK_DIR}/agent.yaml"
orch_name=$(grep '^name:' "$orchestrator_yaml" | head -1 | awk '{print $2}')
orch_model=$(grep '^model:' "$orchestrator_yaml" | head -1 | awk '{print $2}')
orch_system=$(python3 - <<EOF
import yaml
with open("${orchestrator_yaml}") as f:
    d = yaml.safe_load(f)
print(d.get("system_prompt", "").strip())
EOF
)

orch_body=$(python3 -c "
import json
d = {
    'name': '${orch_name}',
    'model': '${orch_model}',
    'system_prompt': '''${orch_system}''',
    'callable_agents': $(python3 -c "import json; print(json.dumps([str(i) for i in [$(IFS=,; echo "${SUBAGENT_IDS[*]:-}")]]))"),
}
print(json.dumps(d))
")

orch_response=$(api_post "/agents" "$orch_body")
orch_id=$(echo "$orch_response" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])" 2>/dev/null || true)

if [[ -z "$orch_id" ]]; then
  echo "ERROR creating orchestrator: ${orch_response}" >&2
  exit 1
fi

echo ""
echo "==> Deployment complete!"
echo "    Agent slug   : ${AGENT_SLUG}"
echo "    Orchestrator : ${orch_id}"
echo "    Subagents    : ${SUBAGENT_IDS[*]:-none}"
echo ""
echo "Invoke with:"
echo "  python3 scripts/invoke_agent.py --agent-id ${orch_id} --event '<steering event>'"
