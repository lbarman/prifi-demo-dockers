# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    echo "*** CTRL-C"
    sudo docker-compose down

    #remove the scripts
    for c in client1 client2 relay
    do
        rm -f plot_web_$c.sh
        rm -f plot_vnc_$c.sh
        rm -f bash_$c.sh
    done

    #remove prifi logs
    rm -f prifi/relay.log
    rm -f prifi/trustee0.log
    rm -f prifi/trustee1.log

    exit 0
}

xpos=1600
ypos=0
w=500
h=400

sudo systemctl start docker
sudo docker-compose up -d

echo "Waiting for the images to boot..."
sleep 5

count=0
for c in client1 client2 relay
do
    #remove old scripts
    rm -f plot_web_$c.sh
    rm -f plot_vnc_$c.sh
    rm -f bash_$c.sh

    #write interactive bash script for containers
    echo "sudo docker exec -it $c /bin/bash -c 'cd /prifi; /bin/bash'" > bash_$c.sh
    chmod u+x bash_$c.sh

    #find the interface where the web traffic goes
    ifaceWeb=$(sudo docker exec $c bash -c "cat /iface_web" 2>/dev/null)
    ifindex1=$(sudo docker exec $c bash -c "cat /sys/class/net/$ifaceWeb/iflink" 2>/dev/null)
    for iface in /sys/class/net/veth*
    do
        ifindex2=$(cat $iface/ifindex)
        if [ "$ifindex1" == "$ifindex2" ]
        then
            ifaceName=$(basename "$iface")
            echo "$c WEB -> $ifaceName"

            #write startup script for nload
            echo "./plotIface.sh $ifaceName $c \$1 \$2 $w $h" > plot_web_$c.sh
            chmod u+x plot_web_$c.sh
            count=$(($count+1))
        fi
    done

    #find the interface where the VNC traffic goes
    ifaceWeb=$(sudo docker exec $c bash -c "cat /iface_control" 2>/dev/null)
    ifindex1=$(sudo docker exec $c bash -c "cat /sys/class/net/$ifaceWeb/iflink" 2>/dev/null)
    for iface in /sys/class/net/veth*
    do
        ifindex2=$(cat $iface/ifindex)
        if [ "$ifindex1" == "$ifindex2" ]
        then
            ifaceName=$(basename "$iface")
            echo "$c VNC -> $ifaceName"

            #write startup script for nload
            echo "./plotIface.sh $ifaceName $c \$1 \$2 $w $h" > plot_vnc_$c.sh
            chmod u+x plot_vnc_$c.sh
            count=$(($count+1))
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