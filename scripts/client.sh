# loads a webpage and waits
function loadWebPage {
  page="$1"
  duration="$2"

  echo "Loading $page for max $duration"

  # create a temporary profile
  PROFILENAME=testProfile
  PROFILEDIR=/tmp/firefoxCache
  DISPLAY=":1" firefox -CreateProfile "$PROFILENAME $PROFILEDIR"
  sleep 1

  # start firefox at the given url
  DISPLAY=":1" firefox -P "$PROFILENAME" "$WEBSITE" -private &
  sleep 5

  # sends F11
  DISPLAY=":1" xdotool search --sync --onlyvisible --class "Firefox" windowactivate key F11

  echo "Waiting $duration..."
  sleep $duration

  echo "Cleaning resources"
  pkill firefox
  rm -rf /home/ubuntu/.mozilla
  rm -rf /tmp
  rm -rf /home/ubuntu/Downloads
  echo ""
}

#quick fix, sometime this does not exists
if [ ! -d "/tmp" ]; then
  echo "Creating /tmp"
  sudo mkdir /tmp
fi

#echo "Changing route to pass by relay..."
#sudo route del default
#sudo route add default gateway relay

echo "Sleeping 20sec..."
sleep 20

while true
do
  #loadWebPage "$WEBSITE" 20
  sleep 20
done
