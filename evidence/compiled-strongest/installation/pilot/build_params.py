"""Assemble the pilot installation's params.json from the measurements in this folder.

usage: python3 build_params.py  (run from installation/pilot/)
Only measured values and declared design values go in; anything this machine cannot measure stays
absent, so commission.py reports it NOT MEASURED."""
import json

power = json.load(open('power-2026-10-29.json'))['summary']
camp = json.load(open('campaign-2026-10-29.json'))['summary']
holds = json.load(open('campaign-2026-10-29.json'))['holds']
durable = json.load(open('../measured-2026-10-29/durable-2026-10-29.json'))
harm = json.load(open('../HARM-CLASSES.json'))['harm_classes']

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
    'measured': {
        'hold_campaign': {
            'trials': camp['hold_fence']['trials'],
            # a hold trial PASSes only with zero landings inside its window, so failed trials bound it
            'landings_while_held': sum(1 for h in holds if not h['PASS']),
            'tau_max_s': camp['hold_fence']['tau_max_s'],
        },
    },
    'accounts': {
        'crash_recovery': {'delta_upper_95': camp['crash_recovery']['delta_upper_95'],
                           'k': camp['crash_recovery']['failures'], 'n': camp['crash_recovery']['trials']},
        'hold_fence': {'delta_upper_95': camp['hold_fence']['delta_upper_95'],
                       'k': camp['hold_fence']['failures'], 'n': camp['hold_fence']['trials']},
    },
    'budget': {'total': 0.05},                         # declared pilot risk budget
    'harm_classes': harm,
}
json.dump(params, open('params-pilot.json', 'w'), indent=1)
print('wrote params-pilot.json')
