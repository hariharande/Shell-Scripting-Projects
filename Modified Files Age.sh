#!/bin/sh
#Ageing script written by Deepak Hariharan
AgeingCalculationFunction () {
	n=`find . -mtime -$1 | wc -l`
	}
	
if [ "$1" = "" ]; then
	AgeingCalculationFunction 5
	echo "There is/are $n file(s) modified 5 or more days ago."
else
	if [ "$1" -ge 0 ]; then
		AgeingCalculationFunction $1
		echo "There is/are $n file(s) modified $1 or more days ago."	
	else
                neg2pos=`expr $1 - $1 - $1`
		while [ $neg2pos != 0 ] ; do
       		        echo "These are the files modified" $neg2pos "days ago."
       		        #AgeingCalculationFunction $neg2pos
			find . -mtime -$neg2pos
       		        echo ""
       		        neg2pos=`expr $neg2pos - 1`
		done
	fi
fi
