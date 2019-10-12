
### MAF

    plink-1.90b6.10 --vcf gt.vcf --freq

    awk 'NR>1 {print $5}' plink.frq > maf.txt
