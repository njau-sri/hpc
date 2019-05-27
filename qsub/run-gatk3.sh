#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

export PATH=/share/apps/java/jre/latest/bin:$PATH

GATK=/share/apps/gatk/3.8-1-0/GenomeAnalysisTK.jar

# your code goes here

# single-sample GVCF calling
java -Xmx4g -jar $GATK -T HaplotypeCaller -R ref.fa -I sample1.bam -ERC GVCF -o sample1.g.vcf
java -Xmx4g -jar $GATK -T HaplotypeCaller -R ref.fa -I sample2.bam -ERC GVCF -o sample2.g.vcf

# joint genotyping
java -Xmx4g -jar $GATK -T GenotypeGVCFs -R ref.fa -V sample1.g.vcf sample2.g.vcf -o all.vcf
