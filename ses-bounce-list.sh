#!/bin/bash

#set -x
STARTDATE="2026-06-17T00:00:00.000000+00:00"
aws sesv2 list-suppressed-destinations --start-date="$STARTDATE" --region us-east-1 --page-size 1000 --output text | tee -a  ./output/bounce-list-0.txt

for i in `seq 1 200`
do
MINUS1=`expr $i - 1`
NEXTTOKEN=`head -n 1 ./output/bounce-list-"$MINUS1".txt`
aws sesv2 list-suppressed-destinations --start-date="$STARTDATE" --region us-east-1 --page-size 1000 --output text --next-token $NEXTTOKEN | tee -a  ./output/bounce-list-$i.txt
cat ./output/bounce-list-$i.txt >> full-bounce-list.txt
#set +x
done
