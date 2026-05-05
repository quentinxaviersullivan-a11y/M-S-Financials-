# Managed Agent Cookbooks

Claude Managed Agent templates for M-S-Financials financial services workflows.
Each agent ships with an `agent.yaml` manifest, `steering-examples.json`, and
a `subagents/` directory containing leaf-worker manifests.

## Agents

| Agent | Vertical | Leaf workers (writer has `write`) |
|-------|----------|-----------------------------------|
| [pitch-agent](./pitch-agent/) | Investment Banking | researcher · modeler · **deck-writer** |
| [market-researcher](./market-researcher/) | Equity Research | sector-reader · comps-spreader · **note-writer** |
| [earnings-reviewer](./earnings-reviewer/) | Equity Research | transcript-reader · model-updater · **note-writer** |
| [meeting-prep-agent](./meeting-prep-agent/) | Wealth Management | profiler · news-reader · **pack-writer** |
| [model-builder](./model-builder/) | Financial Analysis | data-puller · **builder** · auditor |
| [gl-reconciler](./gl-reconciler/) | Finance Ops | reader · critic · **resolver** |
| [kyc-screener](./kyc-screener/) | Compliance | doc-reader · rules-engine · **escalator** |
| [valuation-reviewer](./valuation-reviewer/) | Private Equity | package-reader · valuation-runner · **publisher** |
| [month-end-closer](./month-end-closer/) | Finance Ops | ledger-reader · rollforward · **poster** |
| [statement-auditor](./statement-auditor/) | Private Equity | statement-reader · reconciler · **flagger** |

## Architecture

```
Orchestrator (read, grep, glob only — no write, no bash)
  └── calls subagents via agent_id references
        ├── Reader subagents   — read-only, parse source documents
        ├── Analyst subagents  — read-only, compute / reason
        └── Writer subagent    — ONLY subagent with write permission
```

The orchestrator dispatches work and aggregates results. It never holds write
access directly; all file output is gated through the designated writer leaf.

Cross-agent handoffs emit a `handoff_request` output routed by the deploy
script (or an external orchestrator such as Temporal/Airflow).

## Deployment

```bash
export ANTHROPIC_API_KEY=sk-ant-...
# set any MCP env vars required by the agent (see each agent's agent.yaml)
../scripts/deploy-managed-agent.sh <agent-slug>
```

The script uploads skills, creates leaf workers, then POSTs the resolved
orchestrator config to `POST /v1/agents`.

## Disclaimer

Nothing produced by these agents constitutes investment, legal, tax, or
accounting advice. All output is analyst work-product drafted for human review.
Agents do not make recommendations, execute transactions, or approve decisions.
