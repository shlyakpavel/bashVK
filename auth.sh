function auth {
	APP_ID="12345"
	firefox "https://oauth.vk.com/authorize?client_id=$APP_ID&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,photos,status,messages,wall,groups&response_type=token&v=$API_V"
	echo "12345678912" > token.key
	echo "Copy and paste token here"
	read token
	echo "$token" >> token.key
	echo "Success";
}
function check_auth {
	touch token.key
 	#Check if auth file is empty
	[ -s token.key ] || auth
	#Check if the current time is less then token expiration
	[ $(date +%s) -lt $(head -n 1 token.key) ] || auth
}
