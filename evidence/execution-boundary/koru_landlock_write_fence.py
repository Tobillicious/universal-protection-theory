"""Landlock write/mutation confinement for the fixed synthetic executor.

Linux Landlock ABI v1 or later. No allow-rules are added: the process is
forbidden from performing any handled filesystem write/mutation anywhere.
Reads and ordinary socket I/O are not mediated by this ruleset.
ABI v2 adds REFER; ABI v3 adds TRUNCATE; ABI v5 adds IOCTL_DEV.

This is a research-only layer, NOT general-purpose confinement. Landlock
does not revoke effects on pre-existing writable FDs or shared mappings,
and it does not cover all kernel effect classes. Require successful setup
before action; unsupported kernels MUST fail closed, never silently skip.
"""
LANDLOCK_CHILD_CODE = r"""
import ctypes as _ll_ct, errno as _ll_errno, os as _ll_os, platform as _ll_pl

class _LandlockRulesetAttr(_ll_ct.Structure):
    _fields_=[("handled_access_fs",_ll_ct.c_uint64)]

def _install_write_deny_landlock():
    arch=_ll_pl.machine().lower()
    if arch not in ("x86_64","aarch64","arm64"):
        raise OSError("unsupported Landlock architecture")
    lib=_ll_ct.CDLL(None,use_errno=True)
    # Syscall numbers 444/445/446 are shared by these Linux architectures.
    def call(n,*args):
        result=lib.syscall(_ll_ct.c_long(n),*args)
        if result==-1:
            raise OSError(_ll_ct.get_errno(), "Landlock syscall failed")
        return result
    abi=call(444,_ll_ct.c_void_p(0),_ll_ct.c_size_t(0),_ll_ct.c_uint(1))
    if abi < 1:
        raise OSError("Landlock ABI missing")
    # Intentionally leave READ_FILE, READ_DIR and EXECUTE unhandled.
    rights=(1<<1) | (1<<4) | (1<<5) | (1<<6) | (1<<7) | (1<<8) | (1<<9) | (1<<10) | (1<<11) | (1<<12)
    if abi>=2:
        rights|=1<<13       # REFER: directory-entry reparenting
    if abi>=3:
        rights|=1<<14       # TRUNCATE
    if abi>=5:
        rights|=1<<15       # IOCTL_DEV
    ruleset=_LandlockRulesetAttr(rights)
    fd=call(444,_ll_ct.byref(ruleset),_ll_ct.c_size_t(_ll_ct.sizeof(ruleset)),_ll_ct.c_uint(0))
    try:
        if lib.prctl(38,1,0,0,0)!=0:   # PR_SET_NO_NEW_PRIVS
            raise OSError(_ll_ct.get_errno(),"no_new_privs failed")
        call(446,_ll_ct.c_int(fd),_ll_ct.c_uint(0))
    finally:
        _ll_os.close(fd)
    return abi
"""
