from pathlib import Path


def test_physical_correspondence_gaps_documented():
    root = Path(__file__).resolve().parents[2]
    path = root / "PHYSICAL-CORRESPONDENCE-GAPS.md"
    assert path.exists(), "PHYSICAL-CORRESPONDENCE-GAPS.md must exist"
    text = path.read_text()
    for term in ("side-channel", "jitter", "starvation", "physical correspondence"):
        assert term.lower() in text.lower(), f"missing gap term: {term}"
