#!/bin/bash

if [ -z $1 ];
then
 echo 'Directory not provided. Searching in current directory'
 dir='.'
else
 dir=$1
fi

for f in $dir/*
 do
   orig_name=${f##*/}
   name=$(echo ${orig_name//./+})
   name=$(echo ${name//_/+})
   name=$(echo ${name// /+})
   val="$(curl -s  http://www.imdb.com/find\?ref_\=nv_sr_fn\&q\=$name\&s\=all \
     |grep -o  -E -0  '/tt\w+' |head -1 |cut -c2- )"
     #movie id identified
   data=$(curl -s http://www.imdb.com/title/$val/ |grep "based on" \
     | grep "[0-9]\.[0-9]" -o )
   data1=${data:0:3}    # rating kept in data
   
   printf "$data1" 
   printf " " 
   echo $orig_name 

 done |sort -k1 -rn

