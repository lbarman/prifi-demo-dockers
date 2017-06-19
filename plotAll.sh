# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    echo "*** CTRL-C"
    exit 0
}

pos=$(($2+420))

./plot_web_client1.sh $1 $2 &
./plot_web_client2.sh $1 $pos &

while true
do
    sleep 10
done