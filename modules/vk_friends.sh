function select_friend {
	ID=$1
	friends.get $access_token $ID | tr -d " " > $tmp_dir/friends_"$ID"_ids.txt
	paste -d " " $tmp_dir/friends_"$ID"_firstname.txt $tmp_dir/friends_"$ID"_lastname.txt > $tmp_dir/friends_"$ID"_names_pure.txt
	>$tmp_dir/friends_"$ID"_names.txt
	while read FOO; do
   		echo ${FOO// /\\\ } >> $tmp_dir/friends_"$ID"_names.txt
	done < $tmp_dir/friends_"$ID"_names_pure.txt
	rm $tmp_dir/friends_"$ID"_names_pure.txt $tmp_dir/friends_"$ID"_lastname.txt $tmp_dir/friends_"$ID"_firstname.txt
	#TODO: implement cancel
	paste -d "\n" $tmp_dir/friends_"$ID"_ids.txt $tmp_dir/friends_"$ID"_names.txt | xargs dialog --output-fd 1 --nocancel --menu $"choose_someone" 0 0 0
}
