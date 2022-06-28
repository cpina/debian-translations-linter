#!/bin/bash

set -eu

APT_MIRROR_DIR="/mnt/apt-mirror"
OUTPUT_DIR="/root/output"

mkdir --parents "$OUTPUT_DIR"

find "$APT_MIRROR_DIR" -iname "*orig*" | while read package
do
	echo "Analysing... $package"
	if ! tar -t --wildcards --no-anchored 'ca.po' --to-stdout  -f "$package" 2> /dev/null
	then
		continue
	fi

	#if [ "$ca_found" -ne 0 ]
	#then
	#	# ca.po is not found
	#fi


	BASE_FILENAME=$(basename "$package")
	BASE_FILENAME=$(echo "$BASE_FILENAME" | cut -d _ -f 1)
	OUTPUT_FILE="$OUTPUT_DIR/$BASE_FILENAME-$RANDOM.po"

	tar -x --wildcards --no-anchored 'ca.po' --to-stdout  -f "$package" > "$OUTPUT_FILE"
	echo "Output: $OUTPUT_FILE"

	#tamany_found=$?

	#if [ $tamany_found -eq 0 ]
	#then
		#echo "Tamany in $package"
	#fi
done
