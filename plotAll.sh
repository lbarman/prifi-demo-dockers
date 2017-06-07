# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    echo "*** CTRL-C"
    exit 0
}

./plot_web_client1.sh &
./plot_web_client2.sh &

while true
do
    sleep 10
done