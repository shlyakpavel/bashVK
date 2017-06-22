function copy_status {
while true
do
	status=$(status.get.user "$access_token" $1)
	#echo $status
	status.set "$access_token" $(urlencode "$status") #$status
	sleep 10
done
}
