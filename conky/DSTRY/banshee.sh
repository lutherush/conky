#!/bin/bash
# amaroK info display script by eirc <eirc.eirc@gmail.com>
# banshee info display script by Foppe HEMMINGA <foppe@hemminga.net>
# See /Conky/conky_banshee for details on usage

case "$1" in

# Now Playing Info
artist) 
    art=`exec banshee-1 --query-artist`
    sart=${art:0:5}
    if [ "$sart" != "Error" ]; then
       echo "$art"
    fi
    ;; 
title)  
    tit=`exec banshee-1 --query-title`
    stit=${tit:0:5}
    if [ "$stit" != "Error" ]; then
        echo "$tit"
    fi
    ;;
number) 
    num=`exec banshee-1 --query-track-number`
    snum=${num:0:5}
    if [ "$snum" != "Error" ]; then
        echo "$num"
    fi
    ;;
album)
    alb=`exec banshee-1 --query-album`
    salb=${alb:0:5}
    if [ "$salb" != "Error" ]; then
        echo "$alb"
    fi
    ;;
year)
    yea=`exec banshee-1 --query-year`
    syea=${yea:0:5}
    if [ "$syea" != "Error" ]; then
        echo "$yea"
    fi
    ;;
rating)
    rat=`exec banshee-1 --query-track-rating`
    srat=${rat:0:5}
    if [ "$srat" != "Error" ]; then
        echo "$rat"
    fi
    ;;
duration)
    dur=`exec banshee-1 --query-track-duration`
    sdur=${dur:0:5}
    if [ "$sdur" != "Error" ]; then
        echo "$dur"
    fi
    ;;
track-count)
    tcou=`exec banshee-1 --query-track-count`
    stcou=${tcou:0:5}
    if [ "$stcou" != "Error" ]; then
        echo "$tcou"
    fi
    ;;
uri)
    uri=`exec banshee-1 --query-uri`
    suri=${uri:0:5}
    if [ "$suri" != "Error" ]; then
        echo "$uri"
    fi
    ;;
    
current-state)
    cstat=`exec banshee-1 --query-current-state`
    scstat=${cstat:0:5}
    if [ "$scstat" != "Error" ]; then
        echo "$cstat"
    fi
    ;;
last-state)
    lstat=`exec banshee-1 --query-last-state`
    slstat=${cstat:0:5}
    if [ "$slstat" != "Error" ]; then
        echo "$lstat"
    fi
    ;;
volume)
    vol=`exec banshee-1 --query-volume`
    svol=${vol:0:5}
    if [ "$svol" != "Error" ]; then
        echo "$vol"
    fi
    ;;
position)
    pos=`exec banshee-1 --query-positition`
    spos=${pos:0:5}
    if [ "$spos" != "Error" ]; then
        echo "$pos"
    fi
    ;;
    
progress)
    cu=`exec banshee-1 --query-position`
    to=`exec banshee-1 --query-duration`
    curr=`expr match "${cu:10}" '\([0-9]*\)'`
    tot=`expr match "${to:10}" '\([0-9]*\)'`
    if (( "$tot" )); then
        expr "$curr" \* 100  / "$tot"
    fi
    ;;
esac