#!/bin/bash

K=2

# number of individuals
N=279

# number of replications
R=3

yes | CLUMPP -i K${K}.indfile -k $K -c ${N} -r ${R}
