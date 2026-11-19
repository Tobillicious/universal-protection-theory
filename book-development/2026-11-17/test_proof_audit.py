"""Adversarial checks for the evidence parser, including a real Lean axiom.

The custom-axiom fixture is deliberately untrusted and never imported by the
book proofs. Passing means its compiler report was correctly rejected.
"""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

from proof_audit import verify_axiom_reports


class AxiomAuditTests(unittest.TestCase):
    def test_standard_foundations_are_allowed(self):
        text = "'Example.ok' depends on axioms: [propext,\n Classical.choice, Quot.sound]"
        self.assertEqual(len(verify_axiom_reports(text, ["Example.ok"])), 1)

    def test_missing_duplicate_or_unregistered_reports_are_rejected(self):
        clean = "'Example.ok' does not depend on any axioms\n"
        for output, expected in [
            ("", ["Example.ok"]),
            (clean + clean, ["Example.ok"]),
            (clean, ["Example.other"]),
            (clean, ["Example.ok", "Example.ok"]),
        ]:
            with self.subTest(output=output, expected=expected):
                with self.assertRaises(ValueError):
                    verify_axiom_reports(output, expected)

    def test_sorry_and_arbitrary_custom_axioms_are_rejected(self):
        for axiom in ["sorryAx", "InventedPhysicalLaw", "TrustedGlobalProtection"]:
            with self.subTest(axiom=axiom):
                with self.assertRaises(ValueError):
                    verify_axiom_reports(
                        "'Example.bad' depends on axioms: [" + axiom + "]",
                        ["Example.bad"],
                    )

    def test_actual_lean_compiler_custom_axiom_report_is_rejected(self):
        elan = shutil.which("elan")
        self.assertIsNotNone(elan, "Pinned Lean toolchain required for this check")
        fixture = (
            "import Std\nnamespace HostileAuditFixture\n"
            "axiom inventedPhysicalLaw : False\n"
            "theorem allegedProtection : False := inventedPhysicalLaw\n"
            "#print axioms allegedProtection\nend HostileAuditFixture\n"
        )
        with tempfile.TemporaryDirectory(prefix="upt-axiom-negative-") as tmp:
            source = Path(tmp) / "Fixture.lean"
            source.write_text(fixture)
            env = dict(os.environ)
            env.pop("LEAN_PATH", None)
            result = subprocess.run(
                [elan, "run", "leanprover/lean4:v4.35.0", "lean", str(source)],
                env=env, capture_output=True, text=True, timeout=30,
            )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("inventedPhysicalLaw", result.stdout)
        with self.assertRaisesRegex(ValueError, "Unexpected axiom dependency"):
            verify_axiom_reports(result.stdout, ["HostileAuditFixture.allegedProtection"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
