import sys
import math

infile = sys.argv[1]

if len(sys.argv) > 2:
    outfile = sys.argv[2]
else:
    outfile = infile

with open(infile) as f:
    header = f.readline().strip().split()
    trait = None
    data = []
    for line in f:
        v = line.split()
        if v[1] == "None":
            continue
        if v[0] != trait:
            if trait and data:
                with open(outfile + "." + trait, "w") as ofs:
                    ofs.write("SNP\tCHR\tPOS\tP\tR2\n")
                    ofs.writelines(data)
            trait = v[0]
            del data[:]
        data.append("\t".join([v[1],v[2],v[3],v[6],v[14]+"\n"]))
    if trait and data:
        with open(outfile + "." + trait, "w") as ofs:
            ofs.write("SNP\tCHR\tPOS\tP\tR2\n")
            ofs.writelines(data)
