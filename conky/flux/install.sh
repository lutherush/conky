#!/bin/bash
mv ~/home/.conkyrc ~/home/.conkyrc_bak
copy .conkyrc ~/home
mkdir ~/home/.conky
copy .conky/popup.png ~/home/.conky
killall conky
conky
