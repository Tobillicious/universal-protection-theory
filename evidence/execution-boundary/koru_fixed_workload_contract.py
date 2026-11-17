"""Narrow source-contract auditor for the G3 fixed-marker research workload.

Checks *specific source structure* before anyone may call this a fixed
single-effect authority path. This is a conservative change detector, NOT a
formal proof, runtime OS sandbox, or assurance about imported dependencies.
It intentionally fails when the source shape drifts; changes must be reviewed
and the contract updated with fresh adversarial tests.
"""
import ast
from pathlib import Path

ROOT=Path(__file__).resolve().parent

SOURCES={
    "authority":"koru_authority_owned_marker_service.py",
    "launcher":"koru_no_inherited_fd_executor.py",
}
APPROVED_OPERATIONS=("fixed_marker","hold")
APPROVED_RESOURCE="fixed.marker"


def _function(tree,name):
    matches=[n for n in ast.walk(tree)
             if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)) and n.name==name]
    if len(matches)!=1:
        raise ValueError("expected exactly one "+name)
    return matches[0]


def _source(tree,node):
    return ast.unparse(node)


def _require(value,message):
    if not value:
        raise ValueError(message)


def verify_fixed_workload(authority_source,launcher_source):
    """Verify syntactic contracts for two reviewed modules, or fail closed."""
    authority=ast.parse(authority_source)
    launcher=ast.parse(launcher_source)
    handler=_function(authority,"handle")
    writer=_function(authority,"write_fixed_marker")
    init=_function(authority,"__init__")
    start=_function(launcher,"launch_fixed_executor_client")

    # No arbitrary operation router or user-derived filesystem path:
    # protected endpoint accepts exactly two fixed request objects.
    request_equals=[]
    for node in ast.walk(handler):
        if isinstance(node,ast.Compare) and any(isinstance(op,ast.Eq) for op in node.ops):
            if isinstance(node.left,ast.Name) and node.left.id=="request":
                request_equals.extend(
                    ast.literal_eval(c) for c in node.comparators if isinstance(c,ast.Dict))
    _require(len(request_equals)==2 and
             {tuple(sorted(x.items())) for x in request_equals}==
             {(("op","fixed_marker"),),(("op","hold"),)},
             "authority request allowlist drift")
    h=_source(authority,handler)
    # The handler's complete call graph is a small, fixed reviewed interface.
    # Required strings alone allow an injected direct file write or shell call
    # while all pre-existing phrases remain present. Reject ANY new call
    # expression, including calls nested in a conditional or exception path.
    allowed_handler_calls = {
        "self.request.getsockopt", "struct.calcsize", "struct.unpack",
        "read_framed_request", "json.loads", "self.reply",
        "self.server.journal.admit", "self.server.fence.execute_synthetic",
        "self.server.journal.hold",
    }
    actual_handler_calls = {
        ast.unparse(n.func) for n in ast.walk(handler) if isinstance(n, ast.Call)
    }
    _require(actual_handler_calls == allowed_handler_calls,
             "unreviewed authority handler call or missing required call")
    for phrase in ("uid == self.server.executor_uid",
                   "uid == self.server.controller_uid",
                   "self.server.journal.admit(OPERATION, self.server.expected)",
                   "self.server.fence.execute_synthetic(",
                   "self.server.write_fixed_marker",
                   "self.server.journal.hold()",
                   "'peer_or_operation_denied'"):
        _require(phrase in h,"authority authorization/effect drift: "+phrase)
    _require(len([n for n in ast.walk(handler)
                  if isinstance(n,ast.Call) and isinstance(n.func,ast.Attribute)
                  and n.func.attr=="execute_synthetic"])==1,
             "authority effect call count drift")
    # Callback must be the service method, not data from the client.
    write_code=_source(authority,writer)
    _require('os.open(\'fixed.marker\'' in write_code,
             "fixed marker filename drift")
    for phrase in ("os.O_EXCL","os.O_NOFOLLOW","os.O_CLOEXEC",
                   "dir_fd=self.dirfd","os.fsync(fd)","os.fsync(self.dirfd)"):
        _require(phrase in write_code,"fixed effect safety drift: "+phrase)
    _require(len(writer.args.args)==1 and not writer.args.kwonlyargs,
             "write_fixed_marker must not accept caller arguments")
    _require("self.dirfd = os.open(" in _source(authority,init),
             "authority dirfd ownership drift")

    # In the fixed launcher, every child is dropped to designated UID,
    # inherits no extra descriptors, and starts with the full control chain.
    launch_code=_source(launcher,start)
    for phrase in ("os.setgroups([])","os.setgid(executor_uid)",
                   "os.setuid(executor_uid)","close_fds=True",
                   "pass_fds=()","stdin=subprocess.DEVNULL","cwd='/'",
                   "FD_AUDIT_CHILD_CODE","LANDLOCK_CHILD_CODE",
                   "SECCOMP_CHILD_CODE"):
        _require(phrase in launch_code,"launcher confinement drift: "+phrase)
    # Isolated interpreter with no `site` import: no .pth execution or
    # name-service lookup before the fence. Exact prefix, so dropping or
    # reordering either flag is caught.
    _require("[sys.executable, '-B', '-I', '-S', '-c', FD_AUDIT_CHILD_CODE"
             in launch_code,"launcher interpreter isolation drift")
    # Explicit non-existent HOME: no name-service lookup (nscd/userdb IPC)
    # from the child before its fence; the authority stays the only peer.
    _require("'HOME': '/nonexistent'" in launch_code,
             "launcher pre-fence name-service lookup drift")
    child_values=[n.value.value for n in ast.walk(launcher)
                  if isinstance(n,ast.Assign)
                  for target in n.targets
                  if isinstance(target,ast.Name) and target.id=="_CHILD"
                  and isinstance(n.value,ast.Constant)
                  and isinstance(n.value.value,str)]
    _require(len(child_values)==1,"exactly one fixed child required")
    child=child_values[0]
    for phrase in ("_assert_no_ambient_fds()",
                   "_install_write_deny_landlock()",
                   "_deny_fd_receive_syscalls(deny_new_connections=True)",
                   "socket.SO_PEERCRED",
                   'sock.sendall(b\'{\"op\":\"fixed_marker\"}\\n\')'):
        _require(phrase in child,"fixed child protocol drift: "+phrase)
    _require(child.index("_assert_no_ambient_fds()") <
             child.index("_install_write_deny_landlock()") <
             child.index("sock.connect(sockpath)") <
             child.index("socket.SO_PEERCRED") <
             child.index("_deny_fd_receive_syscalls(deny_new_connections=True)") <
             child.index("sock.sendall("),
             "authority connection / confinement ordering drift")
    _require("sock.connect(sockpath)" in child and
             child.count("sock.connect(")==1 and
             child.count("sock.sendall(")==1 and
             "if active != [sock.fileno()]" in child,
             "single connection and one-fd confinement drift")
    _require("'authority_unavailable_or_uncertain'" in launch_code,
             "missing uncertain failure reporting")
    return True


def verify_checkout():
    return verify_fixed_workload(
        (ROOT/SOURCES["authority"]).read_text(),
        (ROOT/SOURCES["launcher"]).read_text())


if __name__=="__main__":
    verify_checkout()
    print("fixed synthetic workload source contract verified")
