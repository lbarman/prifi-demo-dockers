iface=$1
name=$2

xpos=$3
ypos=$4
w=$5
h=$6

pos=$(($xpos+$w))

./ifaceSample.sh "$iface" | ./driveGnuPlots.pl 2 100 100 "Incoming ($name)" "Outgoing ($name)" "${w}x${h}+${xpos}+${ypos}" "${w}x${h}+${pos}+${ypos}"