
### install

    git clone https://github.com/vcftools/vcftools.git
    cd vcftools/src/cpp/
    ver=$(cat ../../.tarball-version)
    g++ *.cpp bgzf.c -o vcftools-$ver -DPACKAGE_VERSION=\"$ver\" -s -O2 -lz

# SNP density

    vcftools-0.1.17 --vcf gt.vcf --SNPdensity 1000000
