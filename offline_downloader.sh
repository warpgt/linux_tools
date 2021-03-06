#!/bin/bash

cur_dir=`pwd`;

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

L_GREEN='\033[1;32m'
RED='\033[0;31m'
L_CYAN='\033[1;36m'
NC='\033[0m' # No Color

while true; do
	read -p "Type program name to download...`echo $'\n> '`" name
        if [ ! -z "$name" ]; then
        safe_name=$(echo "$name" | sed 's/ /_/g' | sed 's/\./_/g')_install;

        echo -ne "Fix errors (${L_GREEN}sudo apt-get -f -y install${NC})...\n"
        sudo apt-get -f -y install;
        echo -ne "Fixed\n"

        #echo -ne "Putting urls to file ...\n"
        echo -ne "Putting urls to file ...\n"
	apt-get --print-uris --yes install $name | grep ^\' | cut -d\' -f2 > $safe_name.list;
	dep=`wc -l < $safe_name.list`;

	if [ $dep -eq 0 ]; then		
		rm -rf $safe_name.list 2> /dev/null;
		echo -ne "\n"
		printf "No dependencies found. ${L_GREEN}apt-cache search $name | grep $name${NC} results:";
                echo -ne "\n"
		apt-cache search $name | grep "$name";
		echo -ne "\n"
	else
		read -p $'Found \e[1;31m'"$dep"$'\e[0m dependencies, continue? [enter|n].'"`echo $'\n'`" confirm;

                #echo -ne "#####                     (33%)"\\r

                case $confirm in
		[Nn]* ) rm -rf $safe_name.list 2> /dev/null;;
		* ) wget --show-progress -q --input-file $safe_name.list -P $safe_name/;

                #echo -ne  "#############             (66%)"\\r

		chmod 777 -R $safe_name;
		rm -f $safe_name.zip;
		zip -r $safe_name $safe_name/* 2> /dev/null;
		rm -rf $safe_name 2> /dev/null;
		rm -rf $safe_name.list 2> /dev/null;
		chmod 777 $safe_name.zip;
                echo -ne "\n"

                #echo -ne "#######################   (100%)"\\r

		echo -ne "\n"
		printf "${L_GREEN}$safe_name.zip${NC} ready in folder ${L_CYAN}$cur_dir/$safe_name.zip${NC}";
		echo -ne "\n"
		esac
	fi
        fi
done
 
