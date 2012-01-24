#!/bin/bash
cp -v .conkyrc ~/.conkyrc
mkdir ~/.fonts/
cp -v weather.ttf ~/.fonts/weather.ttf
cp -v zoraclockH.ttf ~/.fonts/zoraclockH.ttf
cp -v zoraclockM.ttf ~/.fonts/zoraclockM.ttf
mkdir ~/.scripts/
cp -v clock.sh ~/.scripts/clock.sh
chmod u+x ~/.scripts/clock.sh
cowsay -f sodomized-sheep.cow always better when it\'s free
sleep 15
