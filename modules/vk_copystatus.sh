function copy_status {
#while true
#do
	id=$(dialog --inputbox "Input user ID" 0 0 390061449 --output-fd 1)
	status=$(status.get.user "$access_token" $id)
	#echo $status
	status.set "$access_token" $(urlencode "$status") #$status
#	sleep 10
#done
}
