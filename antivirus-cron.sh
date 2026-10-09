DIR="${1:-safe_dir}"
MALICIOUS_DIR="${2:-safe_malicious}"
WHITELIST_FILE="whitelist.txt"

touch "$WHITELIST_FILE"
mkdir -p "$DIR" "$MALICIOUS_DIR"

for file in "$DIR"/*; do
	if [ -f "$file" ]; then
		filename=$(basename "$file")

		if grep -qxF "$filename" "$WHITELIST_FILE" 2>/dev/null; then
			continue
		fi

		is_malicious=0

		case "$filename" in
			*.exe|*.bat|*.vbs|*.scr|*.ps1) is_malicious=1 ;;
		esac

		if [ $is_malicious -eq 0 ]; then
			if grep -qiE "virus|trojan|malware|worm|ransomware" "$file"; then
				is_malicious=1
			fi
		fi

		if [ $is_malicious -eq 1 ]; then
			echo "$filename is malicious and it is DELETED"
			cp "$file" "$MALICIOUS_DIR/$filename"
			rm "$file"
		fi
	fi
done
