#!/usr/bin/env python3
"""
Invoke a deployed M-S-Financials managed agent with a steering event.

Usage:
    python3 scripts/invoke_agent.py --agent-id <id> --event "<steering event>"
    python3 scripts/invoke_agent.py --agent-id <id> --event-file steering.json

Requires:
    pip install anthropic>=0.45.0
    ANTHROPIC_API_KEY set in environment
"""

import argparse
import json
import os
import sys

import anthropic


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Invoke an M-S-Financials managed agent")
    p.add_argument("--agent-id", required=True, help="Agent ID from deploy script")
    p.add_argument("--event", help="Steering event string")
    p.add_argument("--event-file", help="Path to JSON file with {event: str}")
    p.add_argument(
        "--output-dir",
        default="./out",
        help="Local directory to save agent artifacts (default: ./out)",
    )
    p.add_argument(
        "--max-turns",
        type=int,
        default=50,
        help="Maximum agent turns (default: 50)",
    )
    return p.parse_args()


def load_event(args: argparse.Namespace) -> str:
    if args.event:
        return args.event
    if args.event_file:
        with open(args.event_file) as f:
            data = json.load(f)
        return data["event"]
    sys.exit("Error: provide --event or --event-file")


def main() -> None:
    args = parse_args()
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        sys.exit("Error: ANTHROPIC_API_KEY is not set")

    steering_event = load_event(args)
    os.makedirs(args.output_dir, exist_ok=True)

    client = anthropic.Anthropic(api_key=api_key)

    print(f"Invoking agent {args.agent_id}")
    print(f"Event: {steering_event}")
    print("-" * 60)

    session = client.beta.agents.sessions.create(
        agent_id=args.agent_id,
        betas=["agents-2025-05-15"],
    )

    turn = client.beta.agents.sessions.turns.create(
        agent_id=args.agent_id,
        session_id=session.id,
        messages=[{"role": "user", "content": steering_event}],
        max_turns=args.max_turns,
        betas=["agents-2025-05-15"],
    )

    print(f"Turn ID   : {turn.id}")
    print(f"Stop reason: {turn.stop_reason}")
    print()

    for block in turn.content:
        if hasattr(block, "text"):
            print(block.text)
        elif hasattr(block, "type") and block.type == "tool_use":
            print(f"[tool_use] {block.name}")

    artifacts: list[str] = []
    if hasattr(turn, "output") and turn.output:
        try:
            output = json.loads(turn.output) if isinstance(turn.output, str) else turn.output
            artifacts = output.get("artifacts", [])
        except (json.JSONDecodeError, AttributeError):
            pass

    if artifacts:
        print(f"\nArtifacts produced: {artifacts}")


if __name__ == "__main__":
    main()
