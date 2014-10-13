#!/bin/bash
#FixSerial utility created by Deepak Hariharan
file="$1"
#takes today's date in YYYYMMDD
ReplaceString=`date +%Y%m%d`

  if [ -f $file ]; then
    cp -p $1 $1.bak  
    OLD=`grep ";Serial" $file | awk '{ print $1 }'`
    OLD_1=`echo $OLD | head -c8`    

#Condition handling if Zone file Serial entry > Current Date
    if [ $OLD_1 -gt $ReplaceString ]; then
     echo "Error: Zone file Serial entry > Current Date!"
     exit
     fi
 #Iteration 1: When Zone file Serial date -ne today's date  
     if [ $ReplaceString != $OLD_1 ]; then
	NEW=$(($OLD - 1))
	echo "$NEW"> temp
        #Fetching last 2 digits from the Zone file Serial entry
	NN=`echo $(cat temp) | tail -c2`
	NN=$(($NN + 1))
	#Iteration 1: When last 2 digits from the Zone file Serial entry = 01
	#This is a special scenario since sh omits 0 before 1
	if [ $NN -eq 1 ]; then
	 sed -i "s/$OLD/$ReplaceString"0"$NN/g" $file
	 echo "Fixed entry in $file!" 
	 exit
	fi
    else
#When Zone file Serial date eq today's date  
	NEW=$(($OLD + 1)) 
	echo "$NEW"> temp
	temp1=$(cat temp)
	n=2
        NN=`echo ${temp1:${#temp1} - $n}`
    fi
#When last 2 digits from the Zone file Serial entry <= 9    
    if [ $NN -le 9 ]; then
	sed -i "s/$OLD/$ReplaceString$NN/g" $file
   else
	sed -i "s/$OLD/$ReplaceString$NN/g" $file
   fi
    echo "Fixed entry in $file!" 
 else
    echo "Error:DNS ZoneFile doesn't exist!" 
fi
