echo "Starting longpoll server"
JSON=./JSON.sh

get_json_data(){
	data=$(grep "\[\"$2\"]" $tmp_dir/longpoll_$1.txt)
	data=$(echo ${data##*]} | xargs)
	echo $data
}

longpoll(){
	#Get server info
	request "$api/messages.getLongPollServer.xml?v=$API_V&lp_version=2&access_token=$access_token" > $tmp_dir/longpoll.txt
	key=$(getvalue $tmp_dir/longpoll.txt key | xargs) #Constant for this session
	server=$(getvalue $tmp_dir/longpoll.txt server | xargs) #Constant for this session
	ts=$(getvalue $tmp_dir/longpoll.txt ts | xargs) #Will be overwrited
	rm $tmp_dir/longpoll.txt #The temporary file is not no more requied
	#Infinitive loop
	while true
	do
		echo $ts
		request "https://$server?act=a_check&key=$key&ts=$ts&wait=25&mode=2&version=2" | $JSON -b > $tmp_dir/longpoll_$ts.txt
		new_ts=$(get_json_data $ts ts)
		rm $tmp_dir/longpoll_$ts.txt
		ts=$new_ts
	done
}
