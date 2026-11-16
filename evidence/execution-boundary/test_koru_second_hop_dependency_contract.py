"""Adversarial tests for second-hop G3 authority dependency source integrity.

No effects, root access, or deployment. Mutation objects are in memory.
"""
import ast
import unittest

from koru_second_hop_dependency_contract import (
    ROOT, PINNED_SECOND_HOP, IMPORT_CONTRACTS,
    verify_second_hop_sources, verify_checkout,
)
from koru_pinned_security_dependencies import git_blob_sha


class SecondHopDependencyContractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.contents = {name: (ROOT / name).read_bytes() for name in PINNED_SECOND_HOP}
        cls.owners = {name: (ROOT / name).read_text() for name in IMPORT_CONTRACTS}

    def test_checkout_matches_reviewed_closure(self):
        self.assertTrue(verify_checkout())

    def test_reviewed_blobs_match(self):
        for name, digest in PINNED_SECOND_HOP.items():
            with self.subTest(name=name):
                self.assertEqual(git_blob_sha(self.contents[name]), digest)

    def test_each_second_hop_edit_rejected(self):
        for name in PINNED_SECOND_HOP:
            with self.subTest(name=name):
                changed = dict(self.contents)
                changed[name] += b"\n# changed after review\n"
                with self.assertRaisesRegex(ValueError, "second-hop dependency drift"):
                    verify_second_hop_sources(changed, self.owners)

    def test_ast_inserted_effect_rejected(self):
        changed = dict(self.contents)
        name = "koru_transaction_scoped_effect.py"
        tree = ast.parse(changed[name])
        tree.body.append(ast.parse("print('unexpected effect')").body[0])
        changed[name] = ast.unparse(ast.fix_missing_locations(tree)).encode()
        with self.assertRaisesRegex(ValueError, "second-hop dependency drift"):
            verify_second_hop_sources(changed, self.owners)

    def test_substituted_local_helper_rejected(self):
        owners = dict(self.owners)
        name = "koru_authority_effect_time_fence.py"
        tree = ast.parse(owners[name])
        target = next(n for n in tree.body if isinstance(n, ast.ImportFrom)
                      and n.module == "koru_transaction_scoped_effect")
        target.module = "koru_unreviewed_scoped_effect"
        owners[name] = ast.unparse(tree)
        with self.assertRaisesRegex(ValueError, "second-hop import drift"):
            verify_second_hop_sources(self.contents, owners)

    def test_extra_local_import_rejected(self):
        owners = dict(self.owners)
        name = "koru_durable_effect_intent.py"
        tree = ast.parse(owners[name])
        tree.body.append(ast.parse("from koru_unreviewed import unsafe").body[0])
        owners[name] = ast.unparse(tree)
        with self.assertRaisesRegex(ValueError, "second-hop import drift"):
            verify_second_hop_sources(self.contents, owners)

    def test_aliased_helper_rejected(self):
        owners = dict(self.owners)
        name = "koru_durable_effect_intent.py"
        tree = ast.parse(owners[name])
        target = next(n for n in tree.body if isinstance(n, ast.ImportFrom)
                      and n.module == "koru_transaction_scoped_effect")
        target.names[0].asname = "replacement_helper"
        owners[name] = ast.unparse(tree)
        with self.assertRaisesRegex(ValueError, "aliased local import"):
            verify_second_hop_sources(self.contents, owners)

    def test_missing_source_rejected(self):
        changed = dict(self.contents)
        changed.pop("koru_durable_effect_intent.py")
        with self.assertRaisesRegex(ValueError, "second-hop dependency set changed"):
            verify_second_hop_sources(changed, self.owners)

    def test_missing_import_owner_rejected(self):
        changed = dict(self.owners)
        changed.pop("koru_authority_admission_journal.py")
        with self.assertRaisesRegex(ValueError, "second-hop import-owner set changed"):
            verify_second_hop_sources(self.contents, changed)


if __name__ == "__main__":
    unittest.main()
