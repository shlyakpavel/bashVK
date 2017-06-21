#!/bin/bash
for FILENAME in *.po;
do
lang=$(echo $FILENAME | sed s/.po/""/)
echo processing $lang
mkdir -p ./translations/$lang/LC_MESSAGES/
msgfmt -o main.sh.mo $FILENAME
cp -p main.sh.mo ./translations/$lang/LC_MESSAGES/
done
