"""Assemble the pilot installation's params.json from the measurements in this folder.

usage: python3 build_params.py  (run from installation/pilot/)
Only measured values and declared design values go in; anything this machine cannot measure stays
absent, so commission.py reports it NOT MEASURED."""
import json

power = json.load(open('power-2026-10-29.json'))['summary']
campaign = json.load(open('campaign-application-guard-2026-10-29.json'))
assert campaign.get('completed') is True, 'the campaign is not complete'
camp = campaign['summary']
holds = campaign['holds']
durable = json.load(open('../measured-2026-10-29/durable-2026-10-29.json'))
harm = json.load(open('../HARM-CLASSES.json'))['harm_classes']
gr = json.load(open('guards-records-2026-10-29.json'))
SCRUB_PERIOD_S = 1.0                                   # declared scrub period of the record class
UBER = 1e-15                                           # JEDEC JESD218 client SSD: uncorrectable bit errors per bit read

dur_ns = durable['durable']['duration_ns']
params = {
    'installation': 'Pilot: one Apple M2 MacBook Air (macOS 26.7.1) hosting the reference faithful-hold runtime',
    'meter': {
        'M_W': 30.0,                                   # declared alarm bound = adapter rating
        'measured_max_W': power['SystemLoad_W_max'],   # whole-system load, all sources, under full Lean build
        'measured_mean_W': power['SystemLoad_W_mean'],
        'source': 'AppleSmartBattery PowerTelemetryData SystemLoad, 1 Hz, 118 samples',
    },
    'design': {
        'max_directive_gain': 3.16,                    # 5 dBi, an upper bound for laptop-integrated antennas
        'max_internal_voltage_V': 100.0,               # declared bound on any internal rail (input 20 V USB-PD)
        'hold_interval_bound_s': max(dur_ns) / 1e9 + 0.05,   # worst journaling + one step, declared Delta
    },
    'zones': {'person_m': 0.5, 'devices_m': 0.3},      # the pilot's actual layout: seated user, desk devices
    'guards': {                                        # pilot geometry: the guard (monitor + sink) is co-located
        'rho_m': 0.0,                                  # with the one hosted particular on the same machine
        'signal_speed_m_s': 2.0e8,                     # declared: signal speed in on-board conductors
        'response_s': gr['guard']['permit_grant_s']['max'],
        'deadline_s': None,                            # filled below: the declared hold interval
        'v_m_s': 0.0, 'domain_speed_m_s': 0.0,         # the domain (one machine) does not move or grow
    },
    'records': {                                       # triple-replicated 64 KiB record, majority decoding
        'expected_faults_per_s': UBER * 3 * gr['record']['size_bytes'] * 8 / SCRUB_PERIOD_S,
        'lambda_per_s': None,  # UBER is an average read-error specification, not a pathwise maximum
        'tau_s': SCRUB_PERIOD_S + gr['record']['scrub_s']['max'],
        'code_distance': gr['record']['code_distance'],
        'source': 'JEDEC JESD218 client-class UBER <= 1e-15 per bit read; expected-rate screen only. A class-uniform/pathwise fault bound is not measured.',
    },
    'measured': {
        # FCC grant, FCC ID BCGA2681 (TUV SUD BABT, 6 June 2022): SAR evaluated at 0 mm; highest reported body
        # 0.84 W/kg, simultaneous transmission 1.34 W/kg (the worst case is used)
        'sar': {'W_kg': 1.34, 'source': 'FCC grant BCGA2681 (6 June 2022), simultaneous-transmission SAR at 0 mm'},
        # combined maximum conducted output of all radios at once, from the same grant: 5755-5795 MHz WLAN 0.246 W
        # + 2402-2480 MHz Bluetooth 0.177 W; Part 15 Class B unintentional emissions are negligible beside it
        'rf': {'P_rad_W': 0.246 + 0.177, 'source': 'FCC grant BCGA2681: maximum conducted output per band'},
        'hold_campaign': {
            'trials': camp['hold_fence']['trials'],
            # a hold trial PASSes only with zero landings inside its window, so failed trials bound it
            'landings_while_held': sum(1 for h in holds if not h['PASS']),
            'tau_max_s': camp['hold_fence']['request_to_ack_max_s'],
            'actual_execution_inside_hold_max_s':camp['hold_fence']['tau_max_s'],
        },
    },
    'trial_statistics': {
        'crash_recovery': {'delta_upper_95': camp['crash_recovery']['delta_upper_95'],
                           'k': camp['crash_recovery']['failures'], 'n': camp['crash_recovery']['trials']},
        'hold_fence': {'delta_upper_95': camp['hold_fence']['delta_upper_95'],
                       'k': camp['hold_fence']['failures'], 'n': camp['hold_fence']['trials']},
        'record_scrub': {'delta_upper_95': gr['record']['delta_upper_95'],
                         'k': gr['record']['failures'], 'n': gr['record']['scrubs']},
    },
    'accounts': {'kernel_bounds':None,'kernel_sources':None},
    'budget': {'total': 1e-6, 'screening_total':0.05},
    # founding cover of the pilot domain (one machine, 0.30 x 0.215 m, diameter 0.37 m): one guard (monitor +
    # sink) at the machine covers every location within rho = 0.19 m, the finite cover FoundingCover asks for
    'founding': {'guards_required': 1, 'guards_commissioned': 1},                         # declared pilot risk budget
    'harm_classes': harm,
}
params['guards']['deadline_s'] = params['design']['hold_interval_bound_s']
json.dump(params, open('params-pilot.json', 'w'), indent=1)
print('wrote params-pilot.json')
