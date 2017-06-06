# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    echo "*** CTRL-C"
    sudo docker-compose down
    exit 0
}


sudo systemctl start docker
sudo docker-compose up -d

echo "Waiting for the images to boot..."
sleep 5

count=0
for c in client1 client2 client3
do
    #remove old scripts
    rm -f plot_$c.sh
    rm -f bash_$c.sh

    ifindex1=$(sudo docker exec $c bash -c "cat /sys/class/net/eth0/iflink")
    for iface in /sys/class/net/veth*
    do
        ifindex2=$(cat $iface/ifindex)
        if [ "$ifindex1" == "$ifindex2" ]
        then
            ifaceName=$(basename "$iface")
            echo "$c -> $ifaceName"

            #write startup script for nload
            echo "./plotIface.sh $ifaceName $c $count" > plot_$c.sh
            chmod u+x plot_$c.sh
            count=$(($count+1))

            #write interactive bash script for containers
            echo "sudo docker exec -it $c /bin/bash" > bash_$c.sh
            chmod u+x bash_$c.sh
        fi
    done
done

i=0
while true
do
    echo "Experiment active ($i)..."
    i=$((i+1))
    sleep 10
done