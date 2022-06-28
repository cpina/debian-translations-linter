#!/bin/bash

find . -iname "*orig*" | while read package
do
	echo "Analysing... $package"
	tar -t --wildcards --no-anchored 'ca.po' --to-stdout  -f "$package" 2> /dev/null
	ca_found=$?

	if [ "$ca_found" -ne 0 ]
	then
		# ca.po is not found
		continue
	fi

	tar -x --wildcards --no-anchored 'ca.po' --to-stdout  -f "$package" | grep -i tamany
	tamany_found=$?

	if [ $tamany_found -eq 0 ]
	then
		echo "Tamany in $package"
	fi
done
