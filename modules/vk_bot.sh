function bot {
	#user_id=$(select_friend $id)
	
	#status=$(status.get.user "$access_token" $id)
	while IFS='' read -r line || [[ -n "$line" ]]; do
        messages.send "$access_token" 453886422 $(urlencode "$line") #$status
        sleep 20
        echo "$line"
    done < pg1056.txt

	#for i in {1..100}
    #    do
    #    	messages.send "$access_token" 479036641 $(urlencode "Ty loh $i") #$status
    #    	sleep 1
    #    echo $i
    #    done
	#messages.send "$access_token" 449493612 $(urlencode "HEHE") #$status
}
#TODO make it perfect! Doesn't process russian strings correctly
#pg1056.txt
