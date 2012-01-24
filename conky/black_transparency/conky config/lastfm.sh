 # Similar artists last.fm script from http://slavsan.deviantart.com/
# To be honest this script is made with a little help from some guys from the freenode #bash channel
# 
URL=$(w3m  http://ws.audioscrobbler.com/1.0/user/slavsan/recenttracks.xml | grep -n artist | sed -n "1p" | sed "s/<[^>]""*""[>]//g" | sed "s/4: //g" )  # | sed "s/4:            //g")
URI=  w3m http://ws.audioscrobbler.com/1.0/artist/"$URL"/similar.xml | grep -n name | sed "s/<[^>]""*""[>]//g" | grep -A7 '4:' | grep "4:\\|13:\\|22:\\|31:\\|40:\\|49:\\|58:\\|67:" | grep -v "814:\\|724:\\|634:\\|544:\\|454:\\|364:\\|274:\\|184:\\|94:" | sed 's/4:   //g' | sed 's/13:   //g' | sed 's/22:   //g' | sed 's/31:   //g' | sed 's/40:   //g' | sed 's/49:   //g' | sed 's/58:   //g' | sed 's/67:   //g'
echo $URI
