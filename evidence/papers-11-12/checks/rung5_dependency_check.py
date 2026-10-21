"""Independent all-account rung-5 dependency check, including explicit false-claim controls."""
import json,sys
sys.dont_write_bytecode=True
if hasattr(sys,'set_int_max_str_digits'):sys.set_int_max_str_digits(0)
from rung5.audit import run,false_claim

def main():
    if len(sys.argv)>1:
        claim=sys.argv[1];accepted=bool(false_claim(claim))
        print(json.dumps({'claim':claim,'accepted':accepted},sort_keys=True));return 0 if accepted else 1
    print(json.dumps(run(),sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
