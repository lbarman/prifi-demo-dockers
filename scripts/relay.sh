echo "Gonna enable traffic forwarding..."
sysctl net.ipv4.ip_forward
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo iptables -A FORWARD -j ACCEPT
echo "Added traffic forwarding rules"

while true
do
	echo "Alive"
	sleep 1
done