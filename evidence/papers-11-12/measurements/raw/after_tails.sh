#!/bin/zsh
# Wait for the latency-tail collector to finish, so downloads do not contaminate its samples, then run item 2's network part.
cd /Users/admin/Documents/2026/Snuffy-Book/upt-measurements-raw-claude-2026-10-21
while pgrep -f collect_tails.py > /dev/null; do sleep 20; done
python3 -B state_transfer.py network outputs/state-network-$(date -u +%Y%m%dT%H%M%SZ).jsonl > outputs/state-network.stderr 2>&1
