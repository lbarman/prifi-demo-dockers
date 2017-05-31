echo "Gonna enable traffic forwarding..."
sysctl net.ipv4.ip_forward
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo iptables -A FORWARD -j ACCEPT
echo "Added traffic forwarding rules"

sudo ifconfig eth0 "$IP" netmask 255.255.255.0

ifconfig

while true
do
	echo "Alive"
	sleep 1
done