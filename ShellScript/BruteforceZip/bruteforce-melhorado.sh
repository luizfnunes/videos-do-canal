#!/bin/bash
if [ "$1" == "" -o "$2" == "" ]; then
	echo "Usage: ./$0 <Compacted File> <Wordlist>" 1>&2;
	exit 1
fi
FILE=$1
WORDLIST=$2
if [ ! -e $FILE ]; then
	echo "The parameter [$FILE] is not a file!" 1>&2;
	exit 1
fi
if [ ! -e "$WORDLIST" ]; then
	echo "The parameter [$WORDLIST] is not a file!" 1>&2;
	exit 1
fi
COUNTER=0
for pass in $(cat $WORDLIST);do
	CMD=$(7z t -p$pass $FILE 2>&1 | grep 'password')
	if [ "$CMD" == "" ]; then
		echo "Password found: $pass"
		exit 0;
	fi
	if [ $(($COUNTER%5)) -eq 0 ];then
		echo "Verifed Passwords: $COUNTER";
	fi;
	COUNTER=$(($COUNTER+1))
done
echo "Not password found!"
