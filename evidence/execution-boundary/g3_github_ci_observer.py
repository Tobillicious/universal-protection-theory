"""Read-only GitHub-backed R7 workflow evidence observation.

Fetch GitHub's HTTPS API, then use the existing exact-head consistency
validator. This checks recorded CI status, NOT production effect mediation,
external R4 custody, authentic R6 subject protection or independent approval.

Never accept a user-supplied successful-runs payload as an authenticated API
response. GitHub itself and its CI runner remain within this evidence's trust
boundary; do not install this checker as an effect authorization.
"""
import argparse
import json
import os
import re
import sys
from urllib.parse import urlencode
from urllib.request import Request, urlopen

from g3_exact_head_ci_gate import SHA, REQUIRED, inspect

REPO = "Tobillicious/universal-protection-theory"
EXPECTED_BRANCH = "g3/r5-trace-exec-segmentation-20261117"
API = "https://api.github.com/repos/" + REPO + "/actions/runs"


def fetch_page(head_sha, page, *, opener=urlopen, token=None):
    if type(head_sha) is not str or not SHA.fullmatch(head_sha):
        raise ValueError("invalid exact commit")
    if type(page) is not int or not 1 <= page <= 20:
        raise ValueError("invalid page number")
    query = urlencode({"head_sha": head_sha, "per_page": 100, "page": page})
    headers = {"Accept": "application/vnd.github+json",
               "User-Agent": "UPT-G3-R7-read-only-observer",
               "X-GitHub-Api-Version": "2022-11-28"}
    if token:
        headers["Authorization"] = "Bearer " + token
    with opener(Request(API + "?" + query, headers=headers), timeout=20) as response:
        data = json.load(response)
    if type(data) is not dict or type(data.get("workflow_runs")) is not list:
        raise ValueError("invalid GitHub Actions response")
    return data["workflow_runs"]


def observe(head_sha, *, fetch=fetch_page):
    """Return a structured status verdict; fail closed on duplicates and API gaps."""
    if type(head_sha) is not str or not SHA.fullmatch(head_sha):
        return {"ok": False, "errors": ["invalid_head_sha"]}
    rows = []
    try:
        for page in range(1, 21):
            batch = fetch(head_sha, page)
            if type(batch) is not list:
                raise ValueError("malformed API page")
            for run in batch:
                if type(run) is not dict:
                    raise ValueError("malformed API run")
                if run.get("event") not in ("pull_request", "push"):
                    continue
                if run.get("head_branch") != EXPECTED_BRANCH:
                    continue
                if run.get("name") not in REQUIRED:
                    continue
                rows.append({k: run.get(k) for k in
                             ("name", "head_sha", "status", "conclusion", "id")})
            if len(batch) < 100:
                break
        else:
            raise ValueError("more than 20 CI pages; completeness unverified")
    except (OSError, ValueError, KeyError, TypeError) as exc:
        return {"ok": False, "errors": ["github_observation_unavailable_or_invalid"]}
    ok, errors = inspect({"head_sha": head_sha, "workflow_runs": rows})
    return {"ok": ok, "errors": errors,
            "observed_run_ids": sorted(
                run["id"] for run in rows if type(run["id"]) is int),
            "R4_independent_custody": "UNASSESSED",
            "R6_authentic_actual_effects": "UNASSESSED",
            "R7_independent_acceptance": "UNASSESSED"}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("head_sha")
    args = parser.parse_args()
    verdict = observe(args.head_sha)
    print(json.dumps(verdict, sort_keys=True))
    raise SystemExit(0 if verdict["ok"] else 1)


if __name__ == "__main__":
    main()
