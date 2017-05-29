while true
do
  echo "Opening $WEBSITE"

  #start firefox at the given url
  PROFILENAME=testProfile
  PROFILEDIR=/tmp/firefoxCache
  DISPLAY=":1" firefox -no-remote -CreateProfile $PROFILENAME $PROFILEDIR "$WEBSITE" -private &
  sleep 5

  #sends F11
  DISPLAY=":1" xdotool search --sync --onlyvisible --class "Firefox" windowactivate key F11

  sleep 20
  pkill firefox

  #clean cache
  rm -rf /home/ubuntu/.mozilla
  rm -rf /tmp
  echo ""
done
