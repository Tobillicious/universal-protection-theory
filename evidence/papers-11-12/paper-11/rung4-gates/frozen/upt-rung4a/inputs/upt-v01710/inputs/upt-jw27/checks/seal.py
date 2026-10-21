"""Seal the controlled working copy after writing deterministic evidence."""
from pathlib import Path
import sys
sys.dont_write_bytecode=True
from check_bank import inventory,sha
ROOT=Path(__file__).resolve().parents[1]

def seal():
    files=[rel for rel in inventory(ROOT) if rel!='SHA256SUMS']
    (ROOT/'SHA256SUMS').write_text(''.join(sha(ROOT/rel)+'  '+rel+'\n' for rel in files))
    return len(files)

if __name__=='__main__':print(seal())
