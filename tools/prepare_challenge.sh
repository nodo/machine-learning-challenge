#!/bin/sh
tail -n+2 $1 | awk -F ',' '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}' > clean.csv
