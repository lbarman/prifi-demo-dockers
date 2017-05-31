sudo ifconfig eth0 "$IP" netmask 255.255.255.0

while true
do
  sleep 20
  echo "Opening $WEBSITE"

  #start firefox at the given url
  PROFILENAME=testProfile
  PROFILEDIR=/tmp/firefoxCache
  firefox -CreateProfile "$PROFILENAME $PROFILEDIR"
  DISPLAY=":1" firefox -P "$PROFILENAME" "$WEBSITE" -private &
  sleep 5

  #sends F11
  DISPLAY=":1" xdotool search --sync --onlyvisible --class "Firefox" windowactivate key F11

  echo "Waiting"
  sleep 20
  pkill firefox

  #clean cache
  rm -rf /home/ubuntu/.mozilla
  rm -rf /tmp
  echo ""
done
