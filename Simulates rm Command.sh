#!/bin/sh
#junk Utility written by Deepak Hariharan
OptSelector="0"
DIR="/usr/local/bin/.junk"
FileName=$*
while getopts lpu: Input
do
	case $Input in
		u)
			for junkFileSet in $*; do
				if [  ! $junkFileSet = "-u" ]; then
					mv $DIR/$junkFileSet .
					echo $junkFileSet moved from $DIR into current directory.
				fi
			done
		OptSelector=1
		;;
		l)
# Prints a long listing of the contents (if any) of the .junk directory. Tackles even if .junk isn't present 
			if [ -d "$DIR" ]; then    
				cd $DIR
				LongListing=`ls -l`
				echo $LongListing
			elif [ ! -d "$DIR" ]; then
				echo $DIR directory does not exist.
			fi
		OptSelector=1
		;;
		p)
# Permantly purges the .junk directory of any files and removes the .junk directory. Tackles even if .junk isn't present 
			if [ ! -d "$DIR" ]; then
				echo $DIR directory does not exist.
			else [ -d "$DIR" ]; 
				rm -r $DIR
				echo $DIR directory purged.
			fi
		OptSelector=1
		;;
	esac
done

if [ "$OptSelector" != "1" ]; then
# Script to move file(s) into temporary hidden - '.junk'. Tackles even if .junk isn't present 
# Special check 1: Only files are moved into .junk. Directories aren't. 
# Special check 2:Running a script without file(s) is handled.
for EveryFile in $*; do
			if [ ! -z $1 ]; then
				if [ ! -d "$DIR" ]; then
					if [ -f "$EveryFile" ]; then
						mkdir $DIR
						mv $EveryFile $DIR
						echo $EveryFile moved into $DIR directory\!
					else
						echo $EveryFile cannot be moved into $DIR directory\! It may be an non-existent file/a directory.					        
					fi
				elif [ -d "$DIR" ]; then
					if [ -f "$EveryFile" ]; then
						mv $EveryFile $DIR
						echo $EveryFile moved into $DIR directory\!
					else
						echo $EveryFile cannot be moved into $DIR directory\! It may be an non-existent file/a directory.					        
					fi				
				fi
			else
				echo 'Filename not entered. Usage: <Scriptname> <File(s)Name>'
		        fi
done
fi

