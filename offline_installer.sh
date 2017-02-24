#!/bin/sh

cur_dir=`pwd`;

# Define your function here
installZip() {
	local safe_name="$1"

	chmod 777 $cur_dir/$safe_name.zip;
	unzip -qqo "$safe_name.zip" -d $cur_dir/ 2> /dev/null;
	chmod 777 -R $cur_dir/$safe_name;
	sudo dpkg -i $cur_dir/$safe_name/*.deb;
	rm -rf $cur_dir/$safe_name 2> /dev/null;
	echo "\n";
	echo "$safe_name installed";
	echo "\n";
}

while true; do
	read -p "Type program name to install...`echo '\n> '`" name
	safe_name=$(echo "$name" | sed 's/ /_/g');
	
	if [ -s "$cur_dir/$safe_name`echo '_install'`.zip" ]; then
		installZip "$safe_name`echo '_install'`"
	else
		if [ -s "$cur_dir/$safe_name.zip" ]; then
			installZip "$safe_name"
		fi
	fi
done
