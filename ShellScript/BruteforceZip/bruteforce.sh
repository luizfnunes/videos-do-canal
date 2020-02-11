#!/bin/bash
if [ "$1" == "" -o "$2" == "" ]; then
	echo "Uso: $0 <Arquivo> <Wordlist>";
	exit 1;
fi
FILE=$1
WORDLIST=$2
if [ ! -e "$FILE" ]; then
	echo "Parâmetro <$FILE> não é um arquivo!";
	exit 1;
fi
if [ ! -e "$WORDLIST" ]; then
	echo "Parâmetro <$WORDLIST> não é um arquivo!";
	exit 1;
fi
for PASS in $(cat $WORDLIST); do
	CMD=$(7z t $FILE -p$PASS 2>&1 | grep "password")
	if [ "$CMD" == "" ]; then
		echo "Senha encontrada: $PASS"
		exit 0;
	fi
done
echo "Senha não encontrada!"
