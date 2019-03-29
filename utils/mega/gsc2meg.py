import sys


infile = sys.argv[1]
outfile = infile + ".meg"


with open(infile) as f1, open(outfile,"w") as f2:
    ind, dat = [], []
    for line in f1:
        v = line.split()
        ind.append("#" + v[0])
        dat.append([1-float(e) for e in v[1:]])
    f2.write("#mega\n\n")
    f2.write("!Title  Genetic Distance (1-ibs);\n")
    f2.write("!Format DataType=distance DataFormat=lowerleft NTaxa={};\n".format(len(ind)))
    f2.write("\n\n")
    f2.write("\n".join(ind))
    f2.write("\n\n\n")
    for i in range(1,len(ind)):
        f2.write("\t".join("{:g}".format(e) for e in dat[i][:i]))
        f2.write("\n")
