#!/bin/bash
#Check dependencies
function notfound {
	echo "$1 not found. Aborting"
	exit 1
}
[ -x "$(command -v dialog)" ] || notfound Dialog
[ -x "$(command -v w3m)" ] || notfound W3m
#Download json library if it is not presented in the current directory
[ -f ./JSON.sh ] || wget https://raw.githubusercontent.com/dominictarr/JSON.sh/master/JSON.sh
chmod a+x JSON.sh 
#Generate translation files
for FILENAME in *.po;
do
lang=$(echo $FILENAME | sed s/.po/""/)
echo processing $lang
mkdir -p ./translations/$lang/LC_MESSAGES/
msgfmt -o main.sh.mo $FILENAME
cp -p main.sh.mo ./translations/$lang/LC_MESSAGES/
rm main.sh.mo
done
