echo enter directorywhich contains movie folder
read dir
for f in $dir/movies/*
 do
    oname=${f##*/}
   # echo $oname
   name=$(echo ${oname//./+})
   name=$(echo ${name//_/+})
   name=$(echo ${name// /+})

   curl   http://www.imdb.com/find\?ref_\=nv_sr_fn\&q\=$name\&s\=all |grep -E -0  '/tt\w+' |cut -c72- >out.txt

   cut -c-9 out.txt >  final.txt

   read val <final.txt

   curl  http://www.imdb.com/title/$val/ >rating.html

   data=$(grep "based on" rating.html|grep "[0-9]\.[0-9]" -o)
  
   data1=${data:0:3}

   printf $data1 >>final_rate.txt
   printf " " >> final_rate.txt
   echo $oname >> final_rate.txt

 done
sort final_rate.txt -o final_rate.txt
