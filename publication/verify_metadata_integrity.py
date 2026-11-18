#!/usr/bin/env python3
"""Syntax/continuity checks for existing UPT publication artifacts.

Do not mutate titles, historical identifiers or DOIs. No network lookup.
A PASS confirms local metadata shape, NOT existence of a Zenodo record.
"""
import json
from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parent.parent
DOI = re.compile(r"^10\.5281/zenodo\.[0-9]+$")
CFF_FIELD = re.compile(r"^([A-Za-z][A-Za-z0-9_-]*):\s*(.*)$", re.MULTILINE)


def check():
    cff = ROOT / "CITATION.cff"
    published = ROOT / "PUBLISHED-4.4.json"
    historical = ROOT / "release.json"
    current = ROOT / "release-v4.6.json"
    for source in (cff, published, historical, current):
        if not source.is_file():
            raise ValueError("missing historical metadata: " + source.name)

    text = cff.read_text(encoding="utf-8")
    values = dict(CFF_FIELD.findall(text))
    for name in ("cff-version", "message", "title", "authors",
                 "version", "doi", "url"):
        if not values.get(name):
            raise ValueError("missing required CFF field: " + name)
    if values["cff-version"].strip("\"'") != "1.2.0":
        raise ValueError("unexpected CFF schema version")
    if "  - family-names:" not in text and "  - name:" not in text:
        raise ValueError("CFF authors list is absent")
    cff_doi = values["doi"].strip("\"' ")
    if not DOI.fullmatch(cff_doi):
        raise ValueError("CFF DOI is not a Zenodo DOI")
    if values["url"].strip("\"' ") != "https://doi.org/" + cff_doi:
        raise ValueError("CFF DOI URL differs from its DOI identifier")

    entry = json.loads(published.read_text(encoding="utf-8"))
    archived = json.loads(historical.read_text(encoding="utf-8"))
    for document, name in ((entry, published.name), (archived, historical.name)):
        if not isinstance(document, dict):
            raise ValueError(name + " must contain a JSON object")
        for key in ("doi", "version"):
            if not document.get(key):
                raise ValueError(name + " missing " + key)
        for key in ("doi", "concept_doi"):
            if key in document and not DOI.fullmatch(str(document[key])):
                raise ValueError(name + " invalid " + key)
    latest = json.loads(current.read_text(encoding="utf-8"))
    if not isinstance(latest, dict):
        raise ValueError("current edition release must be an object")
    if latest.get("identifier") != cff_doi:
        raise ValueError("current 4.6 release and CFF DOI differ")
    if str(latest.get("version")) != values["version"].strip("\\\"' "):
        raise ValueError("current 4.6 release and CFF version differ")
    if entry["doi"] != "10.5281/zenodo.23877060" or str(entry["version"]) != "4.4":
        raise ValueError("historical 4.4 publication receipt was changed")
    if entry.get("record") != "https://zenodo.org/records/23877060":
        raise ValueError("4.4 receipt record URL differs from historical DOI")
    # Continuity: this old record intentionally differs from the 4.4 edition.
    if archived["doi"] == entry["doi"]:
        raise ValueError("historical 2.0.5 and 4.4 records were conflated")
    return ("Historical local citation and publication receipt syntax PASS "
            "(record existence not checked)")


if __name__ == "__main__":
    try:
        print(check())
    except (ValueError, OSError, UnicodeError, json.JSONDecodeError) as exc:
        print("FAIL: " + str(exc), file=sys.stderr)
        sys.exit(1)
