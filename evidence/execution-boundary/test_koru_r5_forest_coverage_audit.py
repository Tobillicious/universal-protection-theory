"""Adversarial research checks; no protected effects, authorization or fixtures."""
import unittest
from koru_r5_forest_coverage_audit import SIX, audit_forest_scope

def examine(**overrides):
    params = {
        "declared_paths": {"authority_socket"},
        "observed_paths": {"authority_socket"},
        "owed_subjects": {"p"},
        "subject_evidence": {"p": {name: True for name in SIX}},
        "external_inventory_verified": True,
        "independent_observer_verified": True,
    }
    params.update(overrides)
    return audit_forest_scope(**params)

class ForestAuditTests(unittest.TestCase):
    def test_complete_claim_still_does_not_grant_authority(self):
        a = examine()
        self.assertEqual(a["status"], "RESEARCH_SCOPE_REVIEW_REQUIRED")
        self.assertFalse(a["authorizes_effect"])
        self.assertFalse(a["hCoverage_proved"])
        self.assertFalse(a["hMeaning_proved"])

    def test_unknown_actual_effect_fails_closed(self):
        a = examine(observed_paths={"authority_socket", "alternate_fd"})
        self.assertIn("unexpected_effect_path:alternate_fd", a["unresolved"])

    def test_missing_measured_path_fails_closed(self):
        a = examine(observed_paths=set())
        self.assertIn("declared_path_not_observed:authority_socket", a["unresolved"])

    def test_no_independent_observer_fails_closed(self):
        a = examine(independent_observer_verified=False)
        self.assertIn("independent_effect_observer_unverified", a["unresolved"])

    def test_no_exhaustive_inventory_fails_closed(self):
        a = examine(external_inventory_verified=False)
        self.assertIn("external_effect_path_inventory_unverified", a["unresolved"])

    def test_missing_each_of_six_duties_fails_closed(self):
        for field in SIX:
            with self.subTest(field=field):
                d = {name: True for name in SIX}
                d[field] = False
                a = examine(subject_evidence={"p": d})
                self.assertIn("unresolved:p:" + field, a["unresolved"])

    def test_omitted_owed_subject_fails_closed(self):
        a = examine(owed_subjects={"p", "q"})
        self.assertIn("missing_subject_evidence:q", a["unresolved"])

    def test_empty_owed_scope_not_vacuously_passed(self):
        a = examine(owed_subjects=set(), subject_evidence={})
        self.assertIn("empty_owed_subject_scope", a["unresolved"])

    def test_empty_effect_scope_not_vacuously_passed(self):
        a = examine(declared_paths=set(), observed_paths=set())
        self.assertIn("empty_declared_effect_path_scope", a["unresolved"])

    def test_malformed_scope_rejected(self):
        with self.assertRaises(ValueError):
            examine(declared_paths=["authority_socket"])

if __name__ == "__main__":
    unittest.main()
