#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

JAVA=/share/apps/java/latest/bin/java
GATK=/share/apps/gatk/3.8-1-0/GenomeAnalysisTK.jar

# your code goes here

# single-sample GVCF calling
$JAVA -Xmx4g -jar $GATK -T HaplotypeCaller -R ref.fa -I sample1.bam -ERC GVCF -o sample1.g.vcf
$JAVA -Xmx4g -jar $GATK -T HaplotypeCaller -R ref.fa -I sample2.bam -ERC GVCF -o sample2.g.vcf

# joint genotyping
$JAVA -Xmx4g -jar $GATK -T GenotypeGVCFs -R ref.fa -V sample1.g.vcf sample2.g.vcf -o all.vcf
