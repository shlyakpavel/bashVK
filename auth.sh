function auth {
	APP_ID="12345"
	URL="https://oauth.vk.com/authorize?client_id=$APP_ID&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,photos,status,messages,wall,groups&response_type=token&v=$API_V"
#TODO: check if w3m is avaible. Make a diff loop to kill the browser in time
	w3m $URL -reqlog 
	token=$(grep Location: ~/.w3m/request.log | grep "#access_token" | tail -1 | cut -c11-)
	#xdg-open $URL && echo "Copy and paste url here" && read token
	expires_in=$(url.getvar "$token" expires_in)
	expr $expires_in + $(date +%s)  > token.key
	url.getvar "$token" token >> token.key
	url.getvar "$token" user_id >> token.key
	echo "Success";
}

function check_auth {
	touch token.key
 	#Check if auth file is empty
	[ -s token.key ] || auth
	#Check if the current time is less then token expiration
	[ $(date +%s) -lt $(head -n 1 token.key) ] || auth
}
