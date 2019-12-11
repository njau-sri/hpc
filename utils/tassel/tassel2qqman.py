import sys

if len(sys.argv) < 2:
    sys.stderr.write("\n*** USAGE: {0} tasselfile <traitname>\n\n".format(sys.argv[0]))
    raise RuntimeError

trait = None
if len(sys.argv) > 2:
    trait = sys.argv[2]

with open(sys.argv[1]) as f:
    header = f.readline().split()
    if "p" not in header:
        sys.stderr.write("\n*** ERROR: not TASSEL statistical test file\n\n")
        raise RuntimeError
    j = header.index("p")
    print("CHR\tBP\tP")
    for line in f:
        v = line.split()
        if v[j] == "NaN":
            continue
        if not trait:
            trait = v[0]
        elif v[0] != trait:
            continue
        print("\t".join([v[2],v[3],v[j]]))

sys.stderr.write("\n*** INFO: trait {0} was selected\n".format(trait))
