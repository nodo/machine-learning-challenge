#!/bin/sh
join -t, output_quality.csv output_type.csv > tmp1
awk -F ',' -v OFS=',' '{ print $1,$2,($3==1 ? "Red" : "White")}' tmp1 > tmp2
echo "id,quality,type\n$(cat tmp2)" > final.csv
rm tmp1
rm tmp2
