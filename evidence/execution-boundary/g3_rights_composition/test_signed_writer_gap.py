"""Cross-component NEGATIVE CONTROL: a recorded rights withdrawal is not
currently consulted by the actual signed G3/G-Mesh filesystem writer.

This intentionally documents a remaining enforcement gap, not a passing
rights-protection guarantee. It must be retired/reversed when a genuine
trusted, effect-time rights boundary is integrated.
"""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "g3_prod_01"))

from g3_prod_01.test_g3_signed_bridge import SignedBridgeTests
from g3_rights_veto.rights_veto import RightsVetoJournal
from g3_prod_01.g3_monitor import sha


class RightsWriterGapWitness(unittest.TestCase):
    def test_withdrawal_is_not_mediated_by_existing_signed_writer(self):
        # Reuse the actual signed G3 permit, controller lease, G-Mesh
        # handshake, fenced writer and filesystem-publishing fixture.
        fixture = SignedBridgeTests(methodName="test_valid_signed_path_writes_once")
        fixture.setUp()
        self.addCleanup(fixture.tearDown)

        rights = RightsVetoJournal(
            fixture.root / "trusted-rights.sqlite", initialize=True)
        self.addCleanup(rights.close)

        event = fixture.event
        output_digest = sha(fixture.html.encode("utf-8"))
        # Match the only presently available event authority reference
        # and exact published bytes. This is still synthetic, not evidence
        # of authentic human rights or real-world consent.
        record_ref = event["authority_ref"]
        self.assertTrue(rights.record_withdrawal(
            record_ref=record_ref,
            subject="synthetic-owed-subject",
            action="publish",
            effect_digest=output_digest,
            generation=1)["ok"])
        veto = rights.inspect(
            record_ref=record_ref,
            subject="synthetic-owed-subject",
            action="publish",
            effect_digest=output_digest,
            expected_generation=1)
        self.assertEqual(veto["code"], "record_withdrawn")
        self.assertTrue(veto["local_veto"])
        self.assertFalse(veto["authorizes_effect"])

        fixture.lease()
        result = fixture.writer.write(fixture.request())
        # DOCUMENTED GAP: this is currently COMMITTED because the signed
        # writer has no trusted rights journal/checkpoint integration.
        # Once effect-time rights mediation exists, the REQUIRED future
        # result is denial with no published artifact. Do not interpret
        # this regression witness as a successful protection check.
        self.assertEqual(result["code"], "committed")
        self.assertEqual(len(list(fixture.out.glob("*.html"))), 1)


if __name__ == "__main__":
    unittest.main()
