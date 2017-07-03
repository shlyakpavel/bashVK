echo "Starting longpoll server"
longpoll(){
	request "$api/messages.getLongPollServer.xml?v=$API_V&lp_version=2&access_token=$access_token" > $tmp_dir/longpoll.txt
	while true
	do
		getvalue $tmp_dir/longpoll.txt key
		getvalue $tmp_dir/longpoll.txt server
		getvalue $tmp_dir/longpoll.txt ts
		sleep 2
	done
}
