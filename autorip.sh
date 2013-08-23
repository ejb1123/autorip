#!/bin/bash

if [ -x /usr/bin/makemkvcon ]
then
echo "makemkvcon found."
else
    echo "Autorip version .1, Copyright (C) 2013 E. Bevenour" 
    echo "Autorip comes with ABSOLUTELY NO WARRANTY; for details type `show w'."
    echo "This is free software, and you are welcome to redistribute it"
    echo "under certain conditions; type `show c' for details."
    echo ""
    echo "Error: makemkvcon is not installed."
    echo "Please install it or contact your system administrator."
    exit 1
fi

#if [ $# != 1 ]
#then
#    echo "Error: too many arguments."
#    exit 1
#fi

clear
    echo "Autorip version .1, Copyright (C) 2013 E. Bevenour" 
    echo "Autorip comes with ABSOLUTELY NO WARRANTY; for details type `show w'."
    echo "This is free software, and you are welcome to redistribute it"
    echo "under certain conditions; type `show c' for details."
dir1=""
member=VolumeChanged
echo "Welcome to autorip."
echo "Directory to save to: "

read dir1
#while [ 1 == 1 ]
#do
dbus-monitor --profile "member='$member'" |
while read -r line; 
do
    echo "mounted"
    vol1=`volname /dev/sr0`
    mkdir $dir1/$vol1
    makemkvcon --minlength=1200 mkv disc:0 all $dir1/$vol1
done
