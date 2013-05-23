#!/bin/bash

if [ "$1" = "-h" ]
then
	echo "1) script to execute, 2) MINUTES"	
	exit 0
fi

MINUTES=$2

if [[ $2 -eq "" ]]
then
	MINUTES="1"
fi

if [[ -f $1 ]]
then
	( crontab -l 2>/dev/null | grep -Fv $1 ; printf -- "*/$MINUTES * * * * $1\n" ) | crontab
else
	echo "File $1 not found"
	exit 1
fi