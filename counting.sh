#!/bin/bash

matches=`ls | grep -e phaseDiagram.*.mat`
for i in $matches
do
n=${#i}
n=$(($n-4))
echo $i | cut -c 13-$n
done
