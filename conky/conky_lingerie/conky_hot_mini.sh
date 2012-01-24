#! /bin/bash

line=$(($RANDOM%`ls /path_to_your_thumbnails/ | wc -l`))
line=$((line + 1)) 

ls /path_to_your_thumbnails/ | nl | while read a b
do
  [ "$a" = "$line" ] && { cp /path_to_your_thumbnails/"$b" /home/$USER/.ckmhot; }
done

exit 0
