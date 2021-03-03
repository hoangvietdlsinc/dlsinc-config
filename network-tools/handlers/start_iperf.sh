#!/bin/bash

echo "Starting iperf on default port 5001 ..."
/usr/bin/iperf3 -s -D
ps -C iperf -o pid --sort=-start_time | grep -v PID | head -1 > iperf.pid
echo "... done"