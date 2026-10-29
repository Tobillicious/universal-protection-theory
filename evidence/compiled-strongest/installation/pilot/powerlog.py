"""Sample the Mac's boundary power telemetry (AppleSmartBattery PowerTelemetryData) at ~1 Hz.
argv: seconds out.json. Records SystemPowerIn (adapter input, mW), SystemLoad (mW), battery
voltage (mV) and instantaneous amperage (mA, positive = charging)."""
import json, re, subprocess, sys, time

def sample():
    out = subprocess.run(['ioreg', '-rw0', '-c', 'AppleSmartBattery'], capture_output=True, text=True).stdout
    def grab(key, text=out):
        m = re.search(r'"%s"=(-?\d+)' % key, text) or re.search(r'"%s" = (-?\d+)' % key, text)
        return int(m.group(1)) if m else None
    amp = grab('InstantAmperage')
    if amp is not None and amp > 2**63: amp -= 2**64
    return {'t': time.time(), 'SystemPowerIn_mW': grab('SystemPowerIn'), 'SystemLoad_mW': grab('SystemLoad'),
            'Voltage_mV': grab('Voltage'), 'InstantAmperage_mA': amp,
            'ExternalConnected': '"ExternalConnected" = Yes' in out}

secs, path = int(sys.argv[1]), sys.argv[2]
rows, t_end = [], time.time() + secs
while time.time() < t_end:
    rows.append(sample()); time.sleep(1)
pin = [r['SystemPowerIn_mW'] for r in rows if r['SystemPowerIn_mW'] is not None]
load = [r['SystemLoad_mW'] for r in rows if r['SystemLoad_mW'] is not None]
bat = [r['Voltage_mV'] * r['InstantAmperage_mA'] / 1e6 for r in rows if r['Voltage_mV'] and r['InstantAmperage_mA'] is not None]
summary = {'samples': len(rows), 'SystemPowerIn_W_max': max(pin) / 1e3, 'SystemPowerIn_W_mean': sum(pin) / len(pin) / 1e3,
           'SystemLoad_W_max': max(load) / 1e3, 'SystemLoad_W_mean': sum(load) / len(load) / 1e3,
           'battery_W_min (negative = discharging)': min(bat), 'battery_W_max': max(bat)}
json.dump({'summary': summary, 'rows': rows}, open(path, 'w'), indent=1)
print(json.dumps(summary, indent=1))
