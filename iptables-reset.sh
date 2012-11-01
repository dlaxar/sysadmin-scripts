#!/bin/bash

#iptables rescue script

FORMAT="%F%T"
SAVEPATH=/root/iptables
LOCKPATH=/root/lock
INTERVAL=10
LOGFILE=/root/reset.log

if [[ ! -d $SAVEPATH ]]
then
	mkdir -p $SAVEPATH >> $LOGFILE
fi

echo "Checking a-time" >> $LOGFILE
if [[ ! -f $LOCKPATH ]]
then
	touch -d "1970-01-01 00:00:00" $LOCKPATH >> $LOGFILE
fi

if [[ `find $LOCKPATH -amin -$INTERVAL | wc --lines` -eq 1 ]]
then
	echo "Lock file was touched $INTERVAL minutes ago. Will not reset file. Exiting." >> $LOGFILE
	exit 0
fi

echo "Starting to reset the iptables-Firewall" >> $LOGFILE

/sbin/iptables-save > $SAVEPATH/`date +$FORMAT`.iptables.conf

/sbin/service iptables restart >> $LOGFILE

echo "Finished saving" >> $LOGFILE
