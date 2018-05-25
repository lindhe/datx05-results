#!/bin/bash

if [ ! $# -eq 2 ]; then
  echo "USAGE:"
  echo "$0 ./test-folder <op>"
  echo "op = [r, w]"
  exit 1
fi

test=$1

if [[ $2 == 'w' ]]; then
  w=1
  r=2
elif [[ $2 == 'r' ]]; then
  w=2
  r=1
fi

tmp=$(mktemp --directory --tmpdir summary.XXX)
base=$(echo $test | cut -d '_' -f 1)
file=$base"_summary.csv"

for s in $test/**/writer_summary.txt; do
  number=$(cat $s | grep "Average from" | cut -d ' ' -f 3)
  op_latency=$(cat $s | grep "All:" | cut -d ' ' -f 2)
  if [[ $w == 1 ]]; then
    line="$number $op_latency\n"
  else
    line="$op_latency\n"
  fi
  printf "$line" >> $tmp/$w
done

for s in $test/**/reader_summary.txt; do
  number=$(cat $s | grep "Average from" | cut -d ' ' -f 3)
  op_latency=$(cat $s | grep "All:" | cut -d ' ' -f 2)
  if [[ $r == 1 ]]; then
    line="$number $op_latency\n"
  else
    line="$op_latency\n"
  fi
  printf "$line" >> $tmp/$r
done


paste $tmp/1 $tmp/2 > $file
sort -n $file -o $file
