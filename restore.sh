dir="$1"
malicious_dir="$2"

while true; do
	files=("$malicious_dir"/*)
	if [ ! -e "${files[0]}" ]; then
		echo "No malicious files to review"
		break
	fi

	count=1
	file_list=()
	for f in "$malicious_dir"/*; do
		if [ -f "$f" ]; then
			file_list+=("$f")
			echo "$count) $(basename "$f")"
			count=$((count + 1))
		fi
	done

	read -p "Pick file number: " choice
	selected_file="${file_list[$((choice-1))]}"
	filename=$(basename "$selected_file")

	read -p "Option (1=Restore, 2=Delete, 3=Skip): " opt

	if [ "$opt" -eq 1 ]; then
		mv "$selected_file" "$dir/$filename"
		echo "Restored $filename to $dir"
	elif [ "$opt" -eq 2 ]; then
		rm "$selected_file"
		echo "$filename permanently deleted"
	elif [ "$opt" -eq 3 ]; then
		continue
	fi
done
