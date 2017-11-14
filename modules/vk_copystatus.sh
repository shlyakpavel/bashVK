function copy_status {
	id=$(select_friend)
	status=$(status.get.user "$access_token" $id)
	status.set "$access_token" $(urlencode "$status") #$status
}
#TODO make it perfect! Doesn't process russian strings correctly
