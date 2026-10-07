# create dictionaries 

dir="$1"
malicious_dir="$2"
interval="$3"

mkdir -p "$dir" "$malicious_dir"

ls -l "$dir" > directory-info.last

for file in "$dir"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
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
            cp "$file" "$malicious_dir/$filename"
            rm "$file"
        fi
    fi
done

while true; do
    sleep "$interval"
    ls -l "$dir" > directory-info.new

    if ! diff directory-info.last directory-info.new > /dev/null 2>&1; then
        for file in "$dir"/*; do
            if [ -f "$file" ]; then
                filename=$(basename "$file")
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
                    cp "$file" "$malicious_dir/$filename"
                    rm "$file"
                fi
            fi
        done
          cp directory-info.new directory-info.last
    fi
done
