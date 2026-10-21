"""Exact controller adapter reference and finite controls, Python 3.9 standard library.

Signatures are a supplied primitive. main() uses an explicit emission-table fixture,
not fake cryptographic evidence; the separate bank check instantiates actual Ed25519.
No PBFT process, clock, hardware or measurement is run by this checker.
"""
import copy
import hashlib
import itertools
import json
import sys

sys.dont_write_bytecode = True
WORD_BYTES = 64
LIMIT = 2**(8*WORD_BYTES)
MAX_BYTES = 2**20
MAX_ITEMS = 2**14
MAX_DEPTH = 24
MAX_SUFFIX = 16


class Invalid(ValueError):
    pass


def need(ok, why):
    if not ok:
        raise Invalid(why)


def uint(x):
    return type(x) is int and 0 <= x < LIMIT


def required_word_bytes(*event_caps):
    need(bool(event_caps) and all(type(x) is int and x >= 0 for x in event_caps), 'finite event caps')
    return max(1, (max(x+1 for x in event_caps).bit_length()+7)//8)


def blob(x, n=32):
    return type(x) is bytes and len(x) == n


def encode(x, depth=0):
    need(depth <= MAX_DEPTH, 'depth')
    if x is None:
        return b'\x00'
    if uint(x):
        return b'\x01' + x.to_bytes(WORD_BYTES, 'big')
    if type(x) is bytes:
        need(len(x) <= MAX_BYTES, 'bytes')
        return b'\x02' + len(x).to_bytes(4, 'big') + x
    if type(x) is list:
        need(len(x) <= MAX_ITEMS, 'items')
        return b'\x03' + len(x).to_bytes(4, 'big') + b''.join(encode(v, depth+1) for v in x)
    raise Invalid('value type/range')


def decode(data):
    need(type(data) is bytes and len(data) <= MAX_BYTES, 'frame bytes')
    budget = [MAX_ITEMS]

    def take(i, n):
        need(i+n <= len(data), 'truncated')
        return data[i:i+n], i+n

    def parse(i, depth):
        need(depth <= MAX_DEPTH and budget[0] > 0, 'parse bound')
        budget[0] -= 1
        tag, i = take(i, 1)
        if tag == b'\x00':
            return None, i
        if tag == b'\x01':
            b, i = take(i, WORD_BYTES)
            return int.from_bytes(b, 'big'), i
        need(tag in (b'\x02', b'\x03'), 'tag')
        b, i = take(i, 4)
        n = int.from_bytes(b, 'big')
        if tag == b'\x02':
            return take(i, n)
        need(n <= budget[0], 'array bound')
        out = []
        for _ in range(n):
            v, i = parse(i, depth+1)
            out.append(v)
        return out, i
    x, end = parse(0, 0)
    need(end == len(data) and encode(x) == data, 'noncanonical/trailing')
    return x


def digest(tag, *xs):
    return hashlib.sha256(encode([tag, 1] + list(xs))).digest()


def ident(i):
    return bytes([i])*32


def context(g=1, boot=1, seq=1, nonce=None):
    return [b'UPT-CTX', 1, ident(1), ident(2), ident(3), ident(4), ident(5), ident(6),
            g, boot, seq, ident(7) if nonce is None else nonce, ident(8), ident(9), 0, 1000, 10, 20]


def ctx_ok(c):
    return (type(c) is list and len(c) == 18 and c[0:2] == [b'UPT-CTX', 1]
            and all(blob(c[i]) for i in (2, 3, 4, 5, 6, 7, 11, 12, 13))
            and all(uint(c[i]) for i in (1, 8, 9, 10, 14, 15, 16, 17))
            and c[14] < c[15] and 0 < c[16] and 0 < c[17])


def scope(c):
    return c[:8] + c[12:]


def config():
    return {'f': 1, 'roster': [0, 1, 2, 3], 'domain': ident(1), 'hash': ident(20),
            'monitor': ident(5), 'authority': ident(10), 'scope': scope(context()),
            'targets': [ident(11), ident(12)]}


def config_ok(cfg):
    r = cfg['roster']
    need(uint(cfg['f']) and len(r) == 3*cfg['f']+1 and r == sorted(set(r))
         and all(uint(i) for i in r), 'committee')


def initial():
    # generation, held, boot, closed, pending [ctx,origin,request], reservation, last floor
    return [1, 0, 1, 0, None, 1, None]


def state_ok(s, height):
    need(type(s) is list and len(s) == 7 and all(uint(s[i]) for i in (0, 1, 2, 3, 5)), 'state')
    need(s[1] in (0, 1) and s[5] == 1, 'phase/reservation')
    need(s[0] < LIMIT-1 or s[1] == 1, 'terminal generation held')
    if s[4] is not None:
        p = s[4]
        need(type(p) is list and len(p) == 3 and ctx_ok(p[0]) and uint(p[1]) and 0 < p[1] <= height
             and type(p[2]) is bytes and p[0][9] == s[2] and p[0][10] == s[3]+1, 'pending')
    if s[6] is not None:
        p = s[6]
        need(type(p) is list and len(p) == 3 and ctx_ok(p[0]) and uint(p[1]) and 0 < p[1] <= height
             and type(p[2]) is bytes and p[0][8]+1 <= s[0], 'retained floor')


def request(cfg, principal, method, c, arg=0):
    rid = digest(b'UPT-REQUEST-ID', principal, method, c, arg)
    return [b'UPT-REQUEST', 1, cfg['hash'], principal, rid, method, c, arg]


def request_ok(cfg, signed, auth):
    a = decode(signed)
    need(type(a) is list and len(a) == 2, 'request wrapper')
    r, sig = a
    need(type(r) is list and len(r) == 8 and r[:3] == [b'UPT-REQUEST', 1, cfg['hash']]
         and blob(r[3]) and blob(r[4]) and uint(r[5]) and 0 <= r[5] <= 4 and ctx_ok(r[6])
         and uint(r[7]) and blob(sig, 64), 'request schema')
    need(r[4] == digest(b'UPT-REQUEST-ID', r[3], r[5], r[6], r[7]), 'request identity')
    role = cfg['authority'] if r[5] in (1, 2) else cfg['monitor']
    need(r[3] == role and auth(r[3], encode(r), sig), 'request authentication/ACL')
    return r


def step(cfg, s, signed, index, auth):
    r = request_ok(cfg, signed, auth)
    method, c, arg = r[5:]
    need(scope(c) == cfg['scope'] and c[2] == cfg['domain'], 'enrolment')
    t = copy.deepcopy(s)
    g, held, boot, closed, pending, reservation, last_floor = s
    reject = [b'Rejected']
    if method == 0:
        # Cached queries return exactly the original result, including after Retire.
        if pending is not None and c[9:11] == pending[0][9:11]:
            if c == pending[0] and signed == pending[2]:
                return t, [b'Grant', c, pending[1]]
            return t, [b'Conflict']
        if g == LIMIT-1 or closed == LIMIT-1:
            return t, [b'Exhausted']
        if c[8] != g or held or c[9] != boot:
            return t, reject
        if c[10] <= closed:
            return t, [b'Closed']
        if pending is not None or c[10] != closed+1:
            return t, [b'Busy']
        t[4] = [c, index, signed]
        return t, [b'Grant', c, index]
    if method == 1:
        if last_floor is not None and c == last_floor[0] and signed == last_floor[2]:
            return t, [b'Floor', c, c[8]+1]
        if c[8] != g:
            return t, reject
        if g == LIMIT-1:
            return t, [b'Exhausted']
        if held:
            return t, [b'AlreadyHeld']
        t[0:2] = [g+1, 1]
        t[6] = [c, index, signed]
        return t, [b'Floor', c, g+1]
    if method == 2:
        if g == LIMIT-1:
            return t, [b'Exhausted']
        if c[8] != g or not held or c[9] <= boot:
            return t, reject
        t[1:5] = [0, c[9], 0, None]
        return t, [b'Released']
    if method == 3:
        if arg <= boot or c[9] != arg:
            return t, reject
        t[2:5] = [arg, 0, None]
        return t, [b'Boot', g, held, arg]
    if pending is not None:
        if arg != pending[0][10] or c != pending[0]:
            return t, reject
        t[3:5] = [max(closed, arg), None]
        return t, [b'Closed']
    return t, [b'Closed'] if arg <= closed else reject


def qc_ok(cfg, cert, tag, auth):
    config_ok(cfg)
    need(type(cert) is list and len(cert) == 2, 'certificate wrapper')
    stmt, signatures = cert
    need(type(stmt) is list and len(stmt) == (11 if tag == b'UPT-FINAL' else 7)
         and stmt[:4] == [tag, 1, cfg['hash'], cfg['domain']], 'certificate statement')
    need(type(signatures) is list and len(signatures) == 2*cfg['f']+1, 'quorum size')
    previous = -1
    for pair in signatures:
        need(type(pair) is list and len(pair) == 2, 'signature pair')
        i, sig = pair
        need(uint(i) and i > previous and i in cfg['roster'] and blob(sig, 64), 'signer identity')
        need(auth(i, encode(stmt), sig), 'signature')
        previous = i
    return stmt


def genesis_root(cfg):
    return digest(b'UPT-GENESIS', cfg['hash'], initial())


def checkpoint_statement(cfg, height, root, state):
    return [b'UPT-CHECKPOINT', 1, cfg['hash'], cfg['domain'], height, root, digest(b'UPT-STATE', state)]


def record_root(record):
    return digest(b'UPT-RECORD', *record)


def check_receipt(cfg, data, expected_request, retained_height, auth):
    frame = decode(data)
    need(type(frame) is list and len(frame) == 8 and frame[:2] == [b'UPT-RECEIPT', 1], 'receipt')
    _, _, state, cp_cert, records, final_cert, position, origin = frame
    cp = qc_ok(cfg, cp_cert, b'UPT-CHECKPOINT', auth)
    height, root = cp[4:6]
    need(uint(height) and height >= retained_height and blob(root), 'checkpoint height/root')
    state_ok(state, height)
    need(cp[6] == digest(b'UPT-STATE', state), 'checkpoint state binding')
    if height == 0:
        need(root == genesis_root(cfg) and state == initial(), 'genesis')
    need(type(records) is list and len(records) <= MAX_SUFFIX and uint(position) and uint(origin), 'suffix')
    selected = None
    if state[4] is not None and position == state[4][1]:
        c, at, req = state[4]
        selected = (req, [b'Grant', c, at])
    if state[6] is not None and position == state[6][1]:
        c, at, req = state[6]
        selected = (req, [b'Floor', c, c[8]+1])
    t = copy.deepcopy(state)
    for rec in records:
        need(type(rec) is list and len(rec) == 5, 'record')
        idx, parent, req, result, sh = rec
        need(uint(idx) and idx == height+1 and idx < LIMIT and parent == root, 'prefix linkage')
        nxt, computed = step(cfg, t, req, idx, auth)
        need(result == computed and sh == digest(b'UPT-STATE', nxt), 'deterministic result/state')
        if idx == position:
            selected = (req, result)
        t, height, root = nxt, idx, record_root(rec)
    need(selected is not None, 'named transition absent')
    req, result = selected
    need(req == expected_request, 'exact named request')
    need(type(result) is list and len(result) == 3 and result[0] in (b'Grant', b'Floor'), 'named success')
    expected = request_ok(cfg, req, auth)
    need(result[1] == expected[6] and expected[5] == (0 if result[0] == b'Grant' else 1), 'operation/result binding')
    need(origin == (result[2] if result[0] == b'Grant' else position), 'origin identity')
    final = qc_ok(cfg, final_cert, b'UPT-FINAL', auth)
    need(final == [b'UPT-FINAL', 1, cfg['hash'], cfg['domain'], cp[4], cp[5], cp[6],
                   height, root, req, encode(result)], 'final prefix/result binding')
    return result, height


def local(c):
    return {'floor': c[8], 'boot': c[9], 'ready': 1, 'consumed': 0, 'pending': c,
            'issued': 0, 'deadline': c[16], 'height': 0}


def accept_grant(s, result, now):
    c = result[1]
    need(result[0] == b'Grant' and s['ready'] == 1 and s['consumed'] == 0 and s['pending'] == c
         and c[8] >= s['floor'] and c[9] == s['boot'] and uint(now)
         and 0 <= now-s['issued'] < c[16] and now < s['deadline'], 'local grant')
    t = copy.deepcopy(s)
    t['consumed'], t['pending'] = 1, None
    return t


def recover(s, checkpoint_floor):
    need(s['boot'] < LIMIT-1, 'boot exhausted')
    t = copy.deepcopy(s)
    t.update(floor=max(s['floor'], checkpoint_floor), boot=s['boot']+1, ready=0, consumed=1, pending=None)
    return t


def install_grant(cfg, data, expected_request, s, now, auth):
    result, height = check_receipt(cfg, data, expected_request, s['height'], auth)
    t = accept_grant(s, result, now)
    t['height'] = max(s['height'], height)
    return t


def install_floor(cfg, data, expected_request, s, expected_context, auth):
    result, height = check_receipt(cfg, data, expected_request, s['height'], auth)
    need(result == [b'Floor', expected_context, expected_context[8]+1], 'exact floor context')
    t = copy.deepcopy(s)
    t.update(floor=max(s['floor'], result[2]), height=max(s['height'], height),
             consumed=1, pending=None)
    return t


def target_ack(cfg, primitive, target, floor_context, target_boot, height):
    # Called by the target only after its actual E-LIN durable application.
    need(target in cfg['targets'], 'target')
    stmt = [b'UPT-TARGET-APPLIED', 1, cfg['hash'], cfg['domain'], floor_context[3],
            floor_context[4], target, digest(b'UPT-HOLD', floor_context),
            floor_context[8], floor_context[8]+1, target_boot, height]
    return [stmt, primitive.sign(target, encode(stmt))]


def complete_hold(cfg, acks, c, expected_boots, auth):
    need(type(acks) is list and len(acks) == len(cfg['targets']), 'all target acknowledgements')
    for target, ack, boot in zip(cfg['targets'], acks, expected_boots):
        need(type(ack) is list and len(ack) == 2 and type(ack[0]) is list and len(ack[0]) == 12,
             'target acknowledgement schema')
        stmt, sig = ack
        need(uint(stmt[11]) and blob(sig, 64), 'target acknowledgement types')
        wanted = [b'UPT-TARGET-APPLIED', 1, cfg['hash'], cfg['domain'], c[3], c[4], target,
                  digest(b'UPT-HOLD', c), c[8], c[8]+1, boot, stmt[11]]
        need(stmt == wanted and auth(target, encode(stmt), sig), 'target acknowledgement binding')
    need(len(expected_boots) == len(cfg['targets']), 'target boot roster')
    return True


class EmissionFixture:
    """Finite signature oracle for deterministic controls, explicitly not cryptography."""
    def __init__(self):
        self.issued = set()

    def sign(self, who, message):
        sig = hashlib.sha512(encode([who, message])).digest()
        self.issued.add((encode(who), message, sig))
        return sig

    def auth(self, who, message, sig):
        return (encode(who), message, sig) in self.issued


def signed_request(cfg, primitive, method, c, arg=0, principal=None):
    p = principal if principal is not None else cfg['authority'] if method in (1, 2) else cfg['monitor']
    r = request(cfg, p, method, c, arg)
    return encode([r, primitive.sign(p, encode(r))])


def certificate(primitive, stmt, voters=(0, 1, 2)):
    return [stmt, [[i, primitive.sign(i, encode(stmt))] for i in voters]]


def make_record(cfg, primitive, state, height, root, req):
    nxt, result = step(cfg, state, req, height+1, primitive.auth)
    rec = [height+1, root, req, result, digest(b'UPT-STATE', nxt)]
    return nxt, rec, record_root(rec)


def make_receipt(cfg, primitive, cp_state, cp_height, cp_root, requests, position, named=None):
    cp = checkpoint_statement(cfg, cp_height, cp_root, cp_state)
    state, height, root, records = copy.deepcopy(cp_state), cp_height, cp_root, []
    selected = named
    for req in requests:
        state, rec, root = make_record(cfg, primitive, state, height, root, req)
        height += 1
        records.append(rec)
        if height == position:
            selected = (req, rec[3])
    need(selected is not None, 'fixture named')
    req, result = selected
    stmt = [b'UPT-FINAL', 1, cfg['hash'], cfg['domain'], cp_height, cp_root, cp[6], height, root, req, encode(result)]
    origin = result[2] if result[0] == b'Grant' else position
    return encode([b'UPT-RECEIPT', 1, cp_state, certificate(primitive, cp), records,
                   certificate(primitive, stmt), position, origin]), state, root


def run_controls():
    names = []

    def check(name, truth):
        need(truth, 'control: '+name)
        names.append(name)

    def refuses(name, fn):
        try:
            fn()
        except Invalid:
            names.append(name)
            return
        raise AssertionError('accepted invalid control: '+name)

    vals = [None, 0, LIMIT-1, b'', ident(9), [], [0, None, [b'a']]]
    for x in vals:
        check('codec_roundtrip_'+str(len(names)), decode(encode(x)) == x)
    for cap in [0, 254, 255, 256, 10**100, 10**120]:
        width = required_word_bytes(cap)
        check('counter_width_'+str(cap), 2**(8*width) > cap+1)
    check('wide_reference_covers_illustrative_finite_bill', LIMIT > 10**120+1)
    for i, x in enumerate([True, -1, LIMIT, 0.5, 'x', {}]):
        refuses('codec_type_'+str(i), lambda x=x: encode(x))
    refuses('trailing_bytes', lambda: decode(encode([1])+b'\x00'))
    for i in range(len(encode([b'a', 1]))):
        refuses('truncation_'+str(i), lambda i=i: decode(encode([b'a', 1])[:i]))
    cfg, sig, c = config(), EmissionFixture(), context()
    req = signed_request(cfg, sig, 0, c)
    receipt, state, root = make_receipt(cfg, sig, initial(), 0, genesis_root(cfg), [req], 1)
    result, height = check_receipt(cfg, receipt, req, 0, sig.auth)
    check('valid_grant', result == [b'Grant', c, 1] and height == 1)
    consumed = accept_grant(local(c), result, 1)
    check('one_refresh', consumed['consumed'] == 1)
    refuses('second_refresh', lambda: accept_grant(consumed, result, 2))
    for now in (c[16], c[16]+1):
        refuses('age_deadline_'+str(now), lambda now=now: accept_grant(local(c), result, now))
    early_deadline = local(c); early_deadline['deadline'] = 3
    refuses('caller_deadline_before_age_limit', lambda: accept_grant(early_deadline, result, 4))
    refuses('negative_local_age', lambda: accept_grant(local(c), result, -1))
    for i in range(2, 18):
        altered = copy.deepcopy(c)
        altered[i] = (bytes([altered[i][0]^1])+altered[i][1:]) if type(altered[i]) is bytes else altered[i]+1
        other = signed_request(cfg, sig, 0, altered)
        refuses('context_field_'+str(i), lambda other=other: check_receipt(cfg, receipt, other, 0, sig.auth))
    for slot in range(3):
        changed = decode(receipt)
        changed[5][1][slot][1] = b'\x00'*64
        refuses('every_final_signature_'+str(slot), lambda changed=changed: check_receipt(cfg, encode(changed), req, 0, sig.auth))
        changed = decode(receipt)
        changed[3][1][slot][1] = b'\x00'*64
        refuses('every_checkpoint_signature_'+str(slot), lambda changed=changed: check_receipt(cfg, encode(changed), req, 0, sig.auth))
    for kind in ('duplicate', 'leader_only', 'extra', 'wrong_key'):
        changed = decode(receipt)
        ss = changed[5][1]
        if kind == 'duplicate': ss[1] = ss[0]
        if kind == 'leader_only': del ss[1:]
        if kind == 'extra': ss.append([3, sig.sign(3, encode(changed[5][0]))])
        if kind == 'wrong_key': ss[-1][0] = 19
        refuses(kind, lambda changed=changed: check_receipt(cfg, encode(changed), req, 0, sig.auth))
    for name, edit in [('state_binding', lambda x: x[2].__setitem__(0, 99)),
                       ('bare_index', lambda x: x.__setitem__(6, 9)),
                       ('origin_binding', lambda x: x.__setitem__(7, 2)),
                       ('invented_success', lambda x: x[4][0][3].__setitem__(2, 99)),
                       ('prefix_parent', lambda x: x[4][0].__setitem__(1, ident(99)))]:
        changed = decode(receipt); edit(changed)
        refuses(name, lambda changed=changed: check_receipt(cfg, encode(changed), req, 0, sig.auth))
    larger = copy.deepcopy(cfg); larger['roster'] = list(range(8))
    refuses('larger_committee_same_threshold', lambda: config_ok(larger))
    total_quorum_pairs = 0
    for f in range(3):
        n, q = 3*f+1, 2*f+1
        for bad in itertools.combinations(range(n), f):
            for a in itertools.combinations(range(n), q):
                for b in itertools.combinations(range(n), q):
                    need(bool((set(a)&set(b))-set(bad)), 'honest intersection')
                    total_quorum_pairs += 1
    check('all_small_quorum_intersections', total_quorum_pairs == 9326)
    changed = copy.deepcopy(c); changed[11] = ident(30)
    conflict = signed_request(cfg, sig, 0, changed)
    _, conflict_result = step(cfg, state, conflict, 2, sig.auth)
    check('same_key_payload_conflict', conflict_result == [b'Conflict'])
    state_again, retry_result = step(cfg, state, req, 2, sig.auth)
    check('retry_origin_unchanged', retry_result == result and state_again == state)
    retire = signed_request(cfg, sig, 1, c)
    held, floor_result = step(cfg, state, retire, 2, sig.auth)
    check('retire_retains_reservation', held[0] == 2 and held[1] == 1 and held[5] == 1)
    _, after_retry = step(cfg, held, req, 3, sig.auth)
    check('retired_lookup_original_only', after_retry == result)
    new = context(seq=2, nonce=ident(31))
    _, denied = step(cfg, held, signed_request(cfg, sig, 0, new), 3, sig.auth)
    check('no_new_retired_grant', denied == [b'Rejected'])
    floor_receipt, _, _ = make_receipt(cfg, sig, initial(), 0, genesis_root(cfg), [req, retire], 2)
    fr, _ = check_receipt(cfg, floor_receipt, retire, 0, sig.auth)
    check('valid_floor_authorisation', fr == floor_result)
    _, floor_state, floor_root = make_receipt(cfg, sig, initial(), 0, genesis_root(cfg), [req, retire], 2)
    floor_cp, _, _ = make_receipt(cfg, sig, floor_state, 2, floor_root, [], 2, (retire, floor_result))
    fcp_result, _ = check_receipt(cfg, floor_cp, retire, 2, sig.auth)
    check('compaction_retains_floor_receipt', fcp_result == floor_result)
    same_floor_state, floor_retry = step(cfg, floor_state, retire, 3, sig.auth)
    check('floor_retry_preserves_origin_and_state', same_floor_state == floor_state and floor_retry == floor_result)
    _, repeated_hold = step(cfg, floor_state, signed_request(cfg, sig, 1, context(g=2)), 3, sig.auth)
    check('held_floor_record_cannot_be_overwritten', repeated_hold == [b'AlreadyHeld'])
    reversed_records = decode(floor_receipt)
    reversed_records[4].reverse()
    refuses('ordered_suffix_cannot_reorder', lambda: check_receipt(cfg, encode(reversed_records), retire, 0, sig.auth))
    floor_installed = install_floor(cfg, floor_receipt, retire, local(c), c, sig.auth)
    refuses('floor_blocks_old_grant', lambda: install_grant(cfg, receipt, req, floor_installed, 1, sig.auth))
    acknowledgements = [target_ack(cfg, sig, t, c, 1, 2) for t in cfg['targets']]
    check('two_targets_applied', complete_hold(cfg, acknowledgements, c, [1, 1], sig.auth))
    refuses('controller_floor_is_not_target_ack', lambda: complete_hold(cfg, [fr], c, [1, 1], sig.auth))
    refuses('one_target_is_not_both', lambda: complete_hold(cfg, acknowledgements[:1], c, [1, 1], sig.auth))
    refuses('target_boot_binding', lambda: complete_hold(cfg, acknowledgements, c, [1, 2], sig.auth))
    # Alternate authentic wrapper over a longer finalised prefix proves the SAME grant.
    wrapper, _, _ = make_receipt(cfg, sig, initial(), 0, genesis_root(cfg), [req, retire], 1)
    wr, _ = check_receipt(cfg, wrapper, req, 0, sig.auth)
    check('different_wrapper_same_grant', wrapper != receipt and wr == result)
    refuses('wrapper_cannot_refresh_twice', lambda: accept_grant(consumed, wr, 2))
    recovered = recover(local(c), 2)
    refuses('restart_disabled', lambda: accept_grant(recovered, result, 1))
    recovered.update(ready=1, consumed=0, pending=c)
    refuses('retained_floor_even_if_ready', lambda: accept_grant(recovered, result, 1))
    just_floor = local(c); just_floor['floor'] = 2
    refuses('floor_guard_in_isolation', lambda: accept_grant(just_floor, result, 1))
    just_boot = local(c); just_boot['boot'] = 2
    refuses('boot_guard_in_isolation', lambda: accept_grant(just_boot, result, 1))
    check('recovery_never_lowers_floor', recover(recovered, 1)['floor'] == 2)
    # A retained pending grant can be proved by the checkpoint without its old log.
    cp_receipt, _, _ = make_receipt(cfg, sig, state, 1, root, [], 1, (req, result))
    cp_result, _ = check_receipt(cfg, cp_receipt, req, 1, sig.auth)
    check('checkpoint_retained_result', cp_result == result)
    refuses('rollback_checkpoint', lambda: check_receipt(cfg, receipt, req, 1, sig.auth))
    close_req = signed_request(cfg, sig, 4, c, 1)
    closed_state, closed_result = step(cfg, state, close_req, 2, sig.auth)
    check('close_highwater', closed_state[3] == 1 and closed_state[4] is None)
    _, closed_retry = step(cfg, closed_state, req, 3, sig.auth)
    check('closed_key_not_reissued', closed_retry == [b'Closed'])
    restored = copy.deepcopy(closed_state)
    _, restored_retry = step(cfg, restored, req, 4, sig.auth)
    check('compaction_preserves_closed_key', restored_retry == [b'Closed'])
    boot_req = signed_request(cfg, sig, 3, context(boot=2), 2)
    booted, _ = step(cfg, held, boot_req, 3, sig.auth)
    check('openboot_preserves_hold_floor', booted[0:3] == [2, 1, 2])
    _, old_after_boot = step(cfg, booted, req, 4, sig.auth)
    check('old_boot_cannot_return_after_recovery', old_after_boot == [b'Rejected'])
    big = initial(); big[0:2] = [LIMIT-1, 1]
    _, exhausted = step(cfg, big, signed_request(cfg, sig, 1, context(g=LIMIT-1)), 1, sig.auth)
    check('generation_exhaustion_stops', exhausted == [b'Exhausted'])
    _, terminal_release = step(cfg, big, signed_request(cfg, sig, 2, context(g=LIMIT-1, boot=2)), 1, sig.auth)
    check('terminal_floor_cannot_release', terminal_release == [b'Exhausted'])
    previous = initial(); previous[0] = LIMIT-2
    terminal, terminal_floor = step(cfg, previous, signed_request(cfg, sig, 1, context(g=LIMIT-2)), 1, sig.auth)
    check('last_generation_can_still_be_retired', terminal[0:2] == [LIMIT-1, 1] and terminal_floor[2] == LIMIT-1)
    badcaller = signed_request(cfg, sig, 1, c, principal=cfg['monitor'])
    refuses('resident_cannot_retire_or_release', lambda: step(cfg, initial(), badcaller, 1, sig.auth))
    return {'status': 'PASS', 'controls': len(names), 'quorum_pairs': total_quorum_pairs,
            'control_names': names, 'cryptography': 'explicit emission-table fixture; not an unforgeability proof',
            'distributed_pbft_run': False, 'measurements_rerun': False}


if __name__ == '__main__':
    print(json.dumps(run_controls(), sort_keys=True))
