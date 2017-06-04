iface=$1

if [ ! -d "/sys/class/net/$iface" ]; then
    echo "Invalid interface name"
    exit 1
fi

tx=0
rx=0

while true
do
    tx2=$(cat /sys/class/net/$iface/statistics/rx_bytes)
    rx2=$(cat /sys/class/net/$iface/statistics/tx_bytes)

    deltaTx=$(($tx2-$tx))
    deltaRx=$(($rx2-$rx))

    echo "0:$deltaRx"
    echo "1:$deltaTx"

    tx=$tx2
    rx=$rx2

    sleep 0.1
done