#!/bin/bash
#Download json library
wget https://raw.githubusercontent.com/dominictarr/JSON.sh/master/JSON.sh
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
