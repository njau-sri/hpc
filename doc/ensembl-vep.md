# Ensembl Variant Effect Predictor (VEP)

### Ensembl Virtual Machine

https://asia.ensembl.org/info/data/virtual_machine.html

http://ftp.ensemblorg.ebi.ac.uk/pub/current_virtual_machine/Ensembl98.ova

password: ensembl

### Ensembl Genomes

http://plants.ensembl.org/index.html

ftp://ftp.ensemblgenomes.org/pub/release-45/plants/variation/vep/glycine_max_vep_45_Glycine_max_v2.1.tar.gz

### Usage

    vmware-hgfsclient
    sudo vmhgfs-fuse .host:/ /mnt/ -o allow_other -o uid=1000

    cd
    mkdir .vep
    tar zxf /mnt/Downloads/glycine_max_vep_45_Glycine_max_v2.1.tar.gz -C .vep

    cd src/ensembl-vep
    ./vep --verbose --genomes --species glycine_max --cache --cache_version 45 --force_overwrite -i /mnt/Downloads/test.vcf
