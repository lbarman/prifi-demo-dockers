#quick fix, sometime this does not exists
if [ ! -d "/tmp" ]; then
  echo "Creating /tmp"
  sudo mkdir /tmp
fi

echo "Changing route to pass by relay..."
sudo route del default
sudo route add default gateway relay

echo "Sleeping 20sec..."
sleep 20

while true
do
  sleep 20
  echo "Opening $WEBSITE"

  #start firefox at the given url
  PROFILENAME=testProfile
  PROFILEDIR=/tmp/firefoxCache
  DISPLAY=":1" firefox -CreateProfile "$PROFILENAME $PROFILEDIR"
  sleep 1
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
