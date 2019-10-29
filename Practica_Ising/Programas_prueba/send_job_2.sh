#!/bin/bash 
# Bash script for running njobs time the same physics and saving each run in a directory
 
change_temp()
{
awk  -v tt=$1 'NF!=2 {print $0} NF==2 {$1=tt;print $0}' input.dat > out
mv out input.dat

}


for temp in 1.2 1.4 1.6
do
    dir=${temp}_temp 
    if [ ! -e $dir ] ; then
        mkdir $dir
    fi

    cp input.dat  $dir
    cd $dir
    change_temp $temp

    echo ../exe # acá va el ejecutable
    cd ../


done
