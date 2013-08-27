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
    #Copyright (C) 2013  E.J. Bevenour

    #This program is free software; you can redistribute it and/or modify
    #it under the terms of the GNU General Public License as published by
    #the Free Software Foundation; either version 2 of the License, or
    #(at your option) any later version.

    #This program is distributed in the hope that it will be useful,
    #but WITHOUT ANY WARRANTY; without even the implied warranty of
    #MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    #GNU General Public License for more details.

    #You should have received a copy of the GNU General Public License along
    #with this program; if not, write to the Free Software Foundation, Inc.,
    #51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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
			notify-send -t 6000 -a autorip -i /usr/share/icons/gnome/256x256/devices/media-optical.png "$vol1 is ripped"
		elif [ $GDMSESSION = "kde-plasma" ]
		then
			notify-send -t 6000 -a autorip -i /usr/share/icons/default.kde4/128x128/actions/tools-rip-video-dvd.png "Rip Status" "$vol1 is ripped"
		fi
		sudo umount /dev/sr0
		sudo eject /dev/sr0
		sleep 10
		else
			echo "No disc mounted."
			sleep 10
	fi
done
