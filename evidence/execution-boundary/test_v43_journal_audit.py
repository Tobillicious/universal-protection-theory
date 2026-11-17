"""Fault injection against the legacy journal's signed evidence audit."""
import hashlib
import hmac
import json
import unittest

from v43_journal_audit import audit

KEY = b"journal-audit-test-only-32-byte-key"


def signed(body):
    msg = "line|journal|" + json.dumps(body, sort_keys=True)
    return dict(body, lmac=hmac.new(KEY, msg.encode(), hashlib.sha256).hexdigest())


class JournalAuditTests(unittest.TestCase):
    def test_legitimate_generation_floor_sequence(self):
        rows = [signed({"op": "write", "gen": 1, "floor_at_apply": 1,
                        "seq": 0, "t": 1.0}),
                signed({"op": "floor", "g": 2, "t": 2.0}),
                signed({"op": "write", "gen": 2, "floor_at_apply": 2,
                        "seq": 1, "t": 3.0})]
        self.assertTrue(audit(rows, KEY, "journal")["valid"])

    def test_unsigned_temporal_corruption_fails(self):
        row = signed({"op": "write", "gen": 1, "floor_at_apply": 1,
                      "seq": 0, "t": 5.0})
        row["t"] = 1.0
        self.assertFalse(audit([row], KEY, "journal")["valid"])

    def test_authenticated_time_regression_fails(self):
        rows = [signed({"op": "floor", "g": 2, "t": 5.0}),
                signed({"op": "floor", "g": 2, "t": 3.0})]
        self.assertIn((1, "timestamp_rollback"),
                      audit(rows, KEY, "journal")["errors"])

    def test_stale_write_after_hold_fails_even_with_valid_mac(self):
        rows = [signed({"op": "floor", "g": 3, "t": 1.0}),
                signed({"op": "write", "gen": 2, "floor_at_apply": 2,
                        "seq": 0, "t": 2.0})]
        self.assertIn((1, "stale_or_mismatched_generation"),
                      audit(rows, KEY, "journal")["errors"])

    def test_duplicate_journal_sequence_fails(self):
        row = {"op": "write", "gen": 1, "floor_at_apply": 1, "seq": 0}
        rows = [signed(dict(row, t=1.0)), signed(dict(row, t=2.0))]
        self.assertIn((1, "sequence_replay_or_gap"),
                      audit(rows, KEY, "journal")["errors"])


if __name__ == "__main__":
    unittest.main()
