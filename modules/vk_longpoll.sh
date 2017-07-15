echo "Starting longpoll server"
JSON=./JSON.sh

get_new_ts(){
	data=$(grep "\[\"$2\"]" $tmp_dir/longpoll_$1.txt)
	data=$(echo ${data##*]} | xargs)
	echo $data
}

process_updates(){
	args=""
	#TODO:	Make all updates count (now only the first one gets executed)
	args_quantity=$(grep "\"updates\",0" $tmp_dir/longpoll_$1.txt | wc -l)
	for (( c=1; c<$args_quantity; c++ ))
	do
		data=$(grep "\"updates\",0,$c" $tmp_dir/longpoll_$1.txt)
		data=$(echo ${data##*]} | xargs)
		args="$args $data"
	done
	cmd=$(grep "\"updates\",0,0" $tmp_dir/longpoll_$1.txt)
	cmd=$(echo ${cmd##*]} | xargs)
	#echo "Executing command: $cmd with args $args"
	#TODO:	Change labels to commands and replace all the debug output to the modules
	case $cmd in
		1  ) notify "Замена флагов сообщения";;
		2  ) notify "Установка флагов сообщения";;
		3  ) notify "Сброс флагов сообщения";;
		4  ) notify "Добавление нового сообщения.";;
		7  ) notify "Прочтение всех исходящих сообщений";;
		8  ) notify "Друг стал онлайн.";;
		9  ) notify "Друг id стал оффлайн";;
		61 ) notify "Пользователь набирает текст в диалоге";;
		*  ) notify "Произошло что-то непонятное";;
	esac
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
		request "https://$server?act=a_check&key=$key&ts=$ts&wait=25&mode=2&version=2" | $JSON -b > $tmp_dir/longpoll_$ts.txt
		new_ts=$(get_new_ts $ts ts)
		process_updates $ts
		rm $tmp_dir/longpoll_$ts.txt
		ts=$new_ts
	done
}
