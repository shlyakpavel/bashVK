#!/bin/bash

function getvalue {
grep $2 $1 | sed -e 's/<[^>]*>//g'
}

function status.set {
curl -s "$api/status.set.xml?text=$2&v=$API_V&access_token=$1" > /dev/null
}

function status.get.user {
curl -s "$api/status.get.xml?user_id=$2&v=$API_V&access_token=$1" > $tmp_dir/status_$2.txt
getvalue $tmp_dir/status_$2.txt text
}
function status.get.group {
curl -s "$api/status.get.xml?group_id=$2&v=$API_V&access_token=$1" > $tmp_dir/status_group_$2.txt
getvalue $tmp_dir/status_group_$2.txt text
}
