import sys


infile = sys.argv[1]
outfile = infile + ".meg"


with open(infile + ".id") as f:
	ind = []
	for line in f:
		v = line.split()
		if len(v) == 1:
			ind.append("#" + v[0])
		elif len(v) == 2:
			ind.append("#" + v[1])

with open(infile) as f1, open(outfile,"w") as f2:
    dat = []
    for line in f1:
        dat.append([float(e) for e in line.split()])
    f2.write("#mega\n\n")
    f2.write("!Title  Genetic Distance (1-ibs);\n")
    f2.write("!Format DataType=distance DataFormat=lowerleft NTaxa={};\n".format(len(ind)))
    f2.write("\n\n")
    f2.write("\n".join(ind))
    f2.write("\n\n\n")
    for i in range(1,len(ind)):
        f2.write("\t".join("{:g}".format(e) for e in dat[i][:i]))
        f2.write("\n")
