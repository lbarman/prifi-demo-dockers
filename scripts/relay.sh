echo "Gonna enable traffic forwarding..."
sysctl net.ipv4.ip_forward
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A FORWARD -j ACCEPT
echo "Added traffic forwarding rules"