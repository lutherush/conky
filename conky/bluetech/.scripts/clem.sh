#!/bin/bash
TRACK=`qdbus org.mpris.clementine /TrackList \
org.freedesktop.MediaPlayer.GetCurrentTrack`
qdbus org.mpris.clementine /TrackList \
org.freedesktop.MediaPlayer.GetMetadata $TRACK \
| sort | egrep "^(title:|artist:)" | sed -e "s/^.*: //g" \
| sed -e ':a;N;$!ba;s/\n/ - /g' | head -c 36
