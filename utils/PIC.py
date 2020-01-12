import sys

# vcftools --freq2 --vcf gt.vcf
# python PIC.py > output.txt

with open("out.frq") as f:
    if "{FREQ}" not in f.readline():
        sys.stderr.write("\n*** ERROR: not VCFtools .frq output file\n\n")
        raise RuntimeError
    for line in f:
        v = line.split()
        p = [float(e) for e in v[4:]]
        m = len(p)
        if m < 2:
            print("NA", "NA")
            continue
        # Weir BS (1996) Genetic data analysis II, Sunderland, MA: Sinauer Associates, Inc
        D = 1.0 - sum([e*e for e in p])
        # Botstein D et al. (1980) Am J Hum Genet 32: 314-331
        PIC = D
        for u in range(m-1):
            for v in range(u+1, m):
                PIC -= 2*p[u]*p[u]*p[v]*p[v]
        print(D, PIC)
