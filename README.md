# linux_tools
Scripts helps working with linux specialy when you move from windows

**offline_downloads** downloads needed *.deb files and compress them into zip file - like setup.exe files in windows

Script generate file e.g: *NAME*_install.zip. Script adds *_install.zip* suffix.

![alt tag](https://github.com/warpgt/linux_tools/blob/master/download.png)

**offline_install** install ready \*.zip files generated by *offline_downloads*

When using *offline_install* you only use name before these suffix.

![alt tag](https://github.com/warpgt/linux_tools/blob/master/install.png)

Very simple scripts which do theirs job, but **if you have ideas how to improve them please give me feedback**.

Scripts don't show:
* progress 
* reason why they cant install software (apt -f install)
