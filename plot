w=500
h=400

./ifaceMon.sh wlp4s0 | ./driveGnuPlots.pl 2 100 100 "Up" "Down" "${w}x${h}" "${w}x${h}"

