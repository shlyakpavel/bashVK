#!/bin/bash
#You can always change it to something else(like wget). This function is only not to hardcore curl as the only network engine.
function request {
curl -s $1
}


function getvalue {
grep $2 $1 | sed -e 's/<[^>]*>//g'
}

function status.set {
request "$api/status.set.xml?text=$2&v=$API_V&access_token=$1" > /dev/null
}

function friends.get {
request "$api/friends.get.xml?user_id=$2&fields=nickname&v=$API_V&access_token=$1" > $tmp_dir/friends_$2.txt
getvalue $tmp_dir/friends_$2.txt "<id>"
getvalue $tmp_dir/friends_$2.txt first_name | tr -d " " > $tmp_dir/friends_$2_firstname.txt
getvalue $tmp_dir/friends_$2.txt last_name | tr -d " "> $tmp_dir/friends_$2_lastname.txt
}

function status.get.user {
request "$api/status.get.xml?user_id=$2&v=$API_V&access_token=$1" > $tmp_dir/status_$2.txt
getvalue $tmp_dir/status_$2.txt text
}

function status.get.group {
request "$api/status.get.xml?group_id=$2&v=$API_V&access_token=$1" > $tmp_dir/status_group_$2.txt
getvalue $tmp_dir/status_group_$2.txt text
}

function messages.send {
request "$api/messages.send.xml?user_id=$2&message=$3&v=$API_V&access_token=$1" > /dev/null
}

function url.struct {
count=1
while [[ $(grep = <<< $var) || "$count" -eq "1" ]]
do
[ "$count" -eq "1" ] || echo "$var"
var=$(echo $1 | cut -d "#" -f2 | cut -d "&" -f$count)
(( count++ ))
done

}

function url.getvar {
url.struct $1 | grep $2 | cut -d "=" -f2
}

function notify {
tput cup $[$(tput lines)-1] 0
printf "%$(tput cols)s" ""
tput cup $[$(tput lines)-1] $[$(tput cols)-${#1}]
printf "$@"
}
