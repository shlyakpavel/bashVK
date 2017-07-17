function copy_status {
	id=$(dialog --inputbox $"uID" 0 0 390061449 --output-fd 1)
	status=$(status.get.user "$access_token" $id)
	status.set "$access_token" $(urlencode "$status") #$status
}
