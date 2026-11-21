"""Adversarial source freeze tests for one fixed G3 synthetic workload.

AST mutations are performed in memory; no source file is modified by tests.
Each mutation intentionally demonstrates the value of detecting extra code
that can evade partial structural-presence checks.
"""
import ast
import unittest

from koru_fixed_entrypoint_freeze import (
    ROOT, REVIEWED_ENTRYPOINT_BLOBS, verify_checkout,
    verify_entrypoint_sources,
)
from koru_pinned_security_dependencies import git_blob_sha

AUTHORITY = "koru_authority_owned_marker_service.py"
LAUNCHER = "koru_no_inherited_fd_executor.py"


def mutate_ast(source, edit):
    tree = ast.parse(source)
    edit(tree)
    return ast.unparse(ast.fix_missing_locations(tree)).encode("utf-8")


class FixedEntrypointFreezeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.sources = {
            name: (ROOT / name).read_bytes()
            for name in REVIEWED_ENTRYPOINT_BLOBS
        }

    def rejected(self, name, modified):
        sources = dict(self.sources)
        sources[name] = modified
        with self.assertRaisesRegex(ValueError, "unreviewed fixed entrypoint drift"):
            verify_entrypoint_sources(sources)

    def test_reviewed_checkout_accepted(self):
        self.assertTrue(verify_checkout())

    def test_baseline_blob_hashes_match(self):
        for name, digest in REVIEWED_ENTRYPOINT_BLOBS.items():
            with self.subTest(name=name):
                self.assertEqual(git_blob_sha(self.sources[name]), digest)

    def test_extra_authority_handler_effect_rejected(self):
        def edit(tree):
            handler = next(n for n in ast.walk(tree)
                           if isinstance(n, ast.ClassDef) and n.name == "_Handler")
            method = next(n for n in handler.body if isinstance(n, ast.FunctionDef)
                          and n.name == "handle")
            method.body.insert(0, ast.parse("self.server.write_fixed_marker()").body[0])
        self.rejected(AUTHORITY, mutate_ast(self.sources[AUTHORITY], edit))

    def test_extra_operation_branch_rejected(self):
        def edit(tree):
            handler = next(n for n in ast.walk(tree)
                           if isinstance(n, ast.ClassDef) and n.name == "_Handler")
            method = next(n for n in handler.body if isinstance(n, ast.FunctionDef)
                          and n.name == "handle")
            for stmt in method.body:
                if isinstance(stmt, ast.Try):
                    stmt.body.insert(-1, ast.parse(
                        "if request == {'op':'unreviewed'}: self.reply({'ok':True})"
                    ).body[0])
                    return
            raise AssertionError("baseline handler try missing")
        self.rejected(AUTHORITY, mutate_ast(self.sources[AUTHORITY], edit))

    def test_pre_confinement_effect_rejected(self):
        def edit(tree):
            assignment = next(n for n in tree.body
                              if isinstance(n, ast.Assign) and any(
                                  isinstance(t, ast.Name) and t.id == "_CHILD"
                                  for t in n.targets))
            child = ast.parse(assignment.value.value)
            original = next(i for i, stmt in enumerate(child.body)
                            if isinstance(stmt, ast.Expr) and
                            isinstance(stmt.value, ast.Call) and
                            isinstance(stmt.value.func, ast.Name) and
                            stmt.value.func.id == "_assert_no_ambient_fds")
            child.body.insert(original, ast.parse(
                "print('extra preflight effect')").body[0])
            edited_child = ast.unparse(ast.fix_missing_locations(child))
            ast.parse(edited_child)  # mutation must remain executable Python
            assignment.value.value = edited_child
        self.rejected(LAUNCHER, mutate_ast(self.sources[LAUNCHER], edit))

    def test_peer_uid_bypass_rejected(self):
        def edit(tree):
            handler = next(n for n in ast.walk(tree)
                           if isinstance(n, ast.FunctionDef) and n.name == "handle")
            for node in ast.walk(handler):
                if (isinstance(node, ast.Assign) and any(
                    isinstance(t, ast.Tuple) and any(
                        isinstance(e, ast.Name) and e.id == "uid" for e in t.elts)
                    for t in node.targets)):
                    handler.body.insert(0, ast.parse(
                        "trusted_uid = self.server.executor_uid").body[0])
                    break
            else:
                raise AssertionError("UID source missing")
        self.rejected(AUTHORITY, mutate_ast(self.sources[AUTHORITY], edit))

    def test_added_top_level_execution_rejected(self):
        def edit(tree):
            tree.body.append(ast.parse("print('unexpected module initialization')").body[0])
        self.rejected(AUTHORITY, mutate_ast(self.sources[AUTHORITY], edit))

    def test_missing_entrypoint_rejected(self):
        incomplete = dict(self.sources)
        incomplete.pop(LAUNCHER)
        with self.assertRaisesRegex(ValueError, "fixed entrypoint set changed"):
            verify_entrypoint_sources(incomplete)

    def test_even_comment_change_requires_reapproval(self):
        self.rejected(AUTHORITY, self.sources[AUTHORITY] + b"\n# review marker\n")


if __name__ == "__main__":
    unittest.main()
