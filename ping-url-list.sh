#!/usr/bin/env bash

URL_LIST=("$@")

failed_sites=()
url_list=("${URL_LIST[@]}")

for i in {1..5}; do
	if [ ${#url_list[@]} -eq 0 ]; then
		exit 0
	fi

	for URL in "${url_list[@]}"; do
		if ! curl -s --head --fail "$URL" >/dev/null; then
			echo "$URL failed $(date +%Y-%m-%d:%H:%M)"
			failed_sites+=("$URL")
		fi
	done

	sleep 3
	echo "retrying failed sites"

	url_list=("${failed_sites[@]}")
	failed_sites=()
done

exit 127
