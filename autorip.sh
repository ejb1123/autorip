#!/bin/bash
clear
dir1=""
member=VolumeChanged
echo "Welcom"
echo "save to: "
read dir1
#while [ 1 == 1 ]
#do
dbus-monitor --profile "member='$member'" |
while read -r line; 
do
    echo "mounted"
    makemkvcon mkv disc:0 all $dir1
done

