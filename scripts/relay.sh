#quick fix, sometime this does not exists
if [ ! -d "/tmp" ]; then
  echo "Creating /tmp"
  sudo mkdir /tmp
fi

echo "Gonna enable traffic forwarding..."
sysctl net.ipv4.ip_forward
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo iptables -A FORWARD -j ACCEPT
echo "Added traffic forwarding rules"

exit 0

echo "Sleeping 20sec..."
sleep 20

while true
do
	echo "Alive"
	sleep 1
done