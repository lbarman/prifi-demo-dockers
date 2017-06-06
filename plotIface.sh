iface=$1
name=$2

w=500
h=400
xpos=100
ypos=100

pos=$(($xpos+$w))

./ifaceSample.sh "$iface" | ./driveGnuPlots.pl 2 100 100 "Up ($name)" "Down ($name)" "${w}x${h}+${xpos}+${ypos}" "${w}x${h}+${pos}+${ypos}"