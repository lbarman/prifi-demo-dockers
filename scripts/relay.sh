#quick fix, sometime this does not exists
if [ ! -d "/tmp" ]; then
  echo "Creating /tmp"
  sudo mkdir /tmp
fi

echo "Sleeping 20sec..."
sleep 20

cd /prifi

rm -f relay.log trustee0.log trustee1.log
./prifi.sh relay-d
./prifi.sh trustee-d 0
./prifi.sh trustee-d 1

while true
do
  echo "Relay is alive..."
  sleep 5
done
