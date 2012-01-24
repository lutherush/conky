#! /bin/bash
function dload()
{
	if [ $lq -lt 100 ] && [ $lq -gt 65 ]; then
	echo '${image ./pix/wlan100.png -s 94x79 -p 10,25}'
	fi
	if [ $lq -lt 66 ] && [ $lq -gt 55 ]; then
	echo '${image ./pix/wlan50.png -s 94x79 -p 10,25}'
	fi
	if [ $lq -lt 56 ] && [ $lq -gt 49 ]; then
	echo '${image ./pix/wlan40.png -s 94x79 -p 10,25}'
	fi
	if [ $lq -lt 50 ] && [ $lq -gt 5 ]; then
	echo '${image ./pix/wlan5.png -s 94x79 -p 10,25}'
	fi


}
function usage()
{
echo '${image ./pix/wlan0.png -s 94x79 -p 10,25}'
}

lq=$(iwconfig wlan0|grep 'Link Quality:'|grep :|grep --max-count=1 -o '\:\([0-9]\+\)'|grep --max-count=1 -o '\([0-9]\+\)')

if [ $lq -lt 5 ]
then
	usage
else
	dload
fi
