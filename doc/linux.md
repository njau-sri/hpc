
### count number of lines (.fq.gz)

```shell
for e in $(ls *.fq.gz)
do
    n=$(gunzip -c $e | wc -l)
    echo $e $n
done
```
