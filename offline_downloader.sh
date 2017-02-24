#!/bin/sh

cur_dir=`pwd`;

while true; do
	read -p "Type program name to download...`echo '\n> '`" name
        if [ ! -z "$name" ]; then
        safe_name=$(echo "$name" | sed 's/ /_/g' | sed 's/\./_/g')_install;

	apt-get --print-uris --yes install $name | grep ^\' | cut -d\' -f2 > $safe_name.list;
	dep=`wc -l < $safe_name.list`;
	if [ $dep -eq 0 ]; then		
		rm -rf $safe_name.list 2> /dev/null;
		echo "\n";
		echo "No dependencies found. apt-cache search results:";		
		apt-cache search $name;		
		echo "\n";
	else
		read -p "Found $dep dependencies, continue? [enter|n].`echo '\n'`" confirm;
		case $confirm in
		[Nn]* ) rm -rf $safe_name.list 2> /dev/null;;
		* ) wget --input-file $safe_name.list -o /dev/null -P $safe_name/ 2> /dev/null;
		chmod 777 -R $safe_name;
		rm -f $safe_name.zip;
		zip -r $safe_name $safe_name/* 2> /dev/null;
		rm -rf $safe_name 2> /dev/null;
		rm -rf $safe_name.list 2> /dev/null;
		chmod 777 $safe_name.zip;
		echo "\n";
		echo "$safe_name.zip ready in folder $cur_dir/$safe_name.zip";
		echo "\n";
		esac
	fi
        fi
done
