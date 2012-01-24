
Type http://xoap.weather.com/search/search?where=[yourcity] to find your location id in your browser and then add your location id to $LOCATION in conkyForecast.py and .conkyrc_weather.  I have included the weather.ttf font for your convenience.  If you want to use imperial instead of metric,  open .conkyrc_weather and at line 82, add  -i to just before ~/scripts/conkyForecast.py
 
 
You can remove the email and update if you like and add something else like gmail or temp etc.   The background will resize itself.  

Put .conkyrc_sys, .conkyrc_net, .conkyrc_disk and .conkyrc_weather in your home directory and .conkyForecast.py in ~/scripts folder

Just run four conkys at startup using the command like this "conky -c .conkyrc_sys" etc.


For archlinux users only, read the README.txt in the arch-updates folder on how to set it up. Put conky-update.pl in your ~/scripts folder.

