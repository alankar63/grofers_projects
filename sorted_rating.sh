: '
1.   This script sort the movies based on imdb rating
2.   If a movie is not there then rating of best match is provided
2.1. If best match is a future movie than it is kept as lowest rating movie
2.2. Movies with same rating are sorted with name 
3.   assumptions :
3.1  directory to be provided after bash command
4.   Output file :final_rate.txt
---------------------------------------------------------------------------
'

touch final_rate.txt
> final_rate.txt
#final_rate needs to be emptied

if [ -z $1 ];
then
   echo 'Directory not provided. Searching in current directory'
   dir='.'
else
   #echo 'Input Directory is' $1
   dir=$1
fi

for f in $dir/*
 do
   orig_name=${f##*/}
   name=$(echo ${orig_name//./+})
   name=$(echo ${name//_/+})
   name=$(echo ${name// /+})
   curl -s  http://www.imdb.com/find\?ref_\=nv_sr_fn\&q\=$name\&s\=all | \
   grep -E -0  '/tt\w+' |cut -c72- > out.txt
   #movie id identified
   
   cut -c-9 out.txt > final.txt
   read val < final.txt
   curl -s http://www.imdb.com/title/$val/ > rating.html
   data=$(grep "based on" rating.html| grep "[0-9]\.[0-9]" -o)
   data1=${data:0:3}
   #rating kept in data
   
   printf $data1 >> final_rate.txt
   printf " " >> final_rate.txt
   echo $orig_name >> final_rate.txt

 done

sort final_rate.txt -o final_rate.txt
