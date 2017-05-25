Iterations=2
SleepTime=60
Counter=0
echo "Date,Queue Max,Tx Queue,Rx Queue,Drops"
while [ ${Counter} -lt ${Iterations} ];do
echo -n "`date +"%Y-%m-%d %T %Z"`,`cat /proc/sys/net/core/rmem_max`";cat /proc/net/udp | grep :0202 | awk '{print "0x"$5","$13}' | sed 's/:/,0x/' | awk -F, --non-decimal-data '{printf("%d,%d,%d\n",$1,$2,$3)}';let Counter=Counter+1;sleep ${SleepTime};done