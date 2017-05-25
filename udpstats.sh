#!/bin/bash
# Author: Darryl Hing (darrylhing at gmail dot com)
# Purpose: Output the Date/Time, UDP TX and RX buffer data, and max buffer size in CSV.
# Details: Uses /proc/sys/net/core/rmem_max to define maximum queue size
#          Uses /proc/net/udp for buffer information (Converted from Hex to Decimal)

## Configurables
Iterations=2
SleepTime=60
Counter=0

# Print program parameters to user
echo "Running ${Iterations} Iterations with ${SleepTime} second delay between observations"
# Print CSV headers at the top
echo "Date,Queue Max,Tx Queue,Rx Queue,Drops"
# While loop to handle each iteration
while [ ${Counter} -lt ${Iterations} ]; do
	# Output the Date, Time, Maximum, and current queue stats for UDP from /proc/net/udp
	echo -n "`date +"%Y-%m-%d %T %Z"`,`cat /proc/sys/net/core/rmem_max`";cat /proc/net/udp | grep :0202 | awk '{print "0x"$5","$13}' | sed 's/:/,0x/' | awk -F, --non-decimal-data '{printf("%d,%d,%d\n",$1,$2,$3)}'
	# Incriment the counter by one
	let Counter=Counter+1
	# If the counter = iterations, don't wait for an additional sleep period to quit.
	if [ ${Counter} -eq ${Iterations} ];then
		exit 0
	else
		sleep ${SleepTime}
	fi
done