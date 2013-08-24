#!/bin/bash
shopt -s nullglob
if [ -x /usr/bin/makemkvcon ]
then
	echo "makemkvcon found."
else
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
dir1=""
echo "Welcome to autorip."
echo "Directory to save to: "
read dir1
while [ 1 == 1 ];
	do
	vol1=`volname /dev/sr0 2>&1 | xargs`
	if [[ $vol1 != "volname: No medium found" ]]
	then
		echo "Mounted."
		mkdir -p $dir1/$vol1
		makemkvcon --minlength=1200 mkv disc:0 all $dir1/$vol1
		dir2="$dir1/$vol1/title.mkv"
		if [[ -e $dir1/$vol1/title00.mkv ]];
		then
			mv $dir1/$vol1/title00.mkv $dir1/$vol1/$vol1.mkv
		fi
		if [ $GDMSESSION = "gnome" ]
		then
			notify-send -t 6000 -a autorip -i /usr/share/icons/gnome/256x256/devices/media-optical.png "$vol1.mkv is ripped"
		elif [ $GDMSESSION = "kde" ]
		then
			kdialog --passivepopup "$vol1.mkv is ripped" 6
		fi
		sudo umount /dev/sr0
		sudo eject /dev/sr0
		sleep 10
		else
			echo "No disc mounted."
			sleep 10
	fi
done
