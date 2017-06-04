w=500
h=400
xpos=100
ypos=100

pos=$(($xpos+$w))

./ifaceSample.sh wlp4s0 | ./driveGnuPlots.pl 2 100 100 "Up" "Down" "${w}x${h}+${xpos}+${ypos}" "${w}x${h}+${pos}+${ypos}"