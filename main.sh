#!/bin/bash

#-----------------TEMPORARY: set language-----------------
export LC_ALL="en_US.utf8"
export LANGUAGE="en_US:en"

#----------------Set locale path--------------------------
TEXTDOMAIN=main.sh
TEXTDOMAINDIR="./translations/"
echo $"welcome"

#----------------Checking the envirmoment-----------------
command -v curl >/dev/null 2>&1 || { echo -e $"curlnotfound" >&2; exit 1; }

#----------------Initializing global variables------------
export API_V="5.65"
export api="https://api.vk.com/method/"
export tmp_dir="./tmp"
mkdir -p $tmp_dir

#----------------Including all source files requied-------
source ./api.sh
source ./auth.sh
source ./encoder.sh
source ./modules/vk_copystatus.sh
source ./modules/vk_longpoll.sh

#----------------Check if auth is needed------------------
check_auth

#----------------Get token--------------------------------
access_token=$(head -n 2 token.key | tail -1)

#----------------Run longpoll-----------------------------
longpoll &
longpoll_pid=$!
#----------------Main body--------------------------------
while true
do
	$(dialog --nocancel --menu $"menu" 0 0 0 \
	copy_status $"cpstatus" \
	3 4\
	break "Exit"\
	--output-fd 1)
done

#---------------Kill background process-------------------
kill $longpoll_pid

#---------------Final Cleanup-----------------------------
rm -rf tmp/
