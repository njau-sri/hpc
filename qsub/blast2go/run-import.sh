#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#
#$ -l mem_free=4G
#

# prerequisite on locahost
#
# http://archive.geneontology.org/latest-full/go_201507-assocdb-data.gz
# ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz
# ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene2accession.gz
# ftp://ftp.pir.georgetown.edu/databases/idmapping/idmapping.tb.gz
#
# # mysql -uroot -proot < b2gdb.sql
# # mysql -uroot -proot -e "GRANT ALL ON b2gdb.* TO 'blast2go'@'localhost' IDENTIFIED BY 'blast4it';"
# # mysql -uroot -proot -e "GRANT ALL ON b2gdb.* TO 'blast2go'@'compute-0-0.local' IDENTIFIED BY 'blast4it';"
# # mysql -uroot -proot -e "GRANT ALL ON b2gdb.* TO 'blast2go'@'compute-0-1.local' IDENTIFIED BY 'blast4it';"
# # mysql -uroot -proot -e "FLUSH PRIVILEGES;"
#

HOST=cluster.local
USER=blast2go
PASS=blast4it
DB=b2gdb

DATA=/ds3512/public/blast2go

echo "import go_201507-assocdb-data"
mysql -h$HOST -u$USER -p$PASS $DB < $DATA/go_201507-assocdb-data

echo "import gene2accession"
mysql -h$HOST -u$USER -p$PASS $DB --local-infile -e "LOAD DATA LOCAL INFILE '$DATA/gene2accession' INTO TABLE gene2accession FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';"

echo "import gene_info"
mysql -h$HOST -u$USER -p$PASS $DB --local-infile -e "LOAD DATA LOCAL INFILE '$DATA/gene_info' INTO TABLE gene_info FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';"

echo "import idmapping.tb"
java -cp .:mysql-connector-java-5.0.8-bin.jar ImportIdMapping $DATA/idmapping.tb $HOST:40000 $DB $USER $PASS
