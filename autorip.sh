#!/bin/bash

if [ -x /usr/bin/makemkvcon ]
then
echo "makemkvcon found."
else
echo "Error: makemkvcon is not installed."
    echo "Please install it or contact your system administrator."
    exit 1
fi

if [ $# != 1 ]
then
    echo "Error: too many arguments."
    exit 1
fi

clear
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
