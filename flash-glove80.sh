#!/usr/bin/env bash

FIRMWARE=""

if [[ -n "$1" ]]; then
	FIRMWARE="$1"
else
	newest_file=$(find ~/Downloads -maxdepth 1 -name "*.uf2" -type f -printf '%T@ %p\n' | sort -n | tail -n 1 | cut -d' ' -f2-)
	FIRMWARE="$newest_file"
	echo "Flashing $FIRMWARE"
fi

function copy_to_volume {
	hand="$1"
	volume="$2"

	dots=('.   ' '..  ' '... ')
	i=0

	echo -n "Waiting for $hand hand boot volume    "

	while true; do
		udisksctl mount -b /dev/sde >/dev/null 2>&1
		if [ $? -eq 0 ]; then
			break
		fi
		((i++))
		echo -n -e "\b\b\b\b${dots[i % 3]}"
		sleep 0.5
	done

	while [[ ! -d "$volume" ]]; do
		((i++))
		echo -n -e "\b\b\b\b${dots[i % 3]}"
		sleep 0.5
	done

	echo -n -e "\b\b\b\b... found"

	sleep 0.5

	echo -en "\033[2K\rFlashing $hand hand    "

	cp -f "$FIRMWARE" "$volume"

	i=0
	while [[ -d "$volume" ]]; do
		echo -n -e "\b\b\b\b${dots[i % 3]}"
		((i++))

		sleep 0.5
	done

	echo -e "\b\b\b\b... done"
}

copy_to_volume "left" "/run/media/$USER/GLV80LHBOOT"
copy_to_volume "right" "/run/media/$USER/GLV80RHBOOT"
