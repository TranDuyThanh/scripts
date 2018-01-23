#!/bin/sh

/root/nvidia-init.sh
sleep 5s
/usr/local/bin/ccminer -a phi -o stratum+tcp://pool.unimining.net:8333 -u LL7CXjxPC2SYKhGRSvvSPJVTPWzNyWcHeM -p c=LUX --cpu-priority=3 --api-allow=0/0 --api-bind=0.0.0.0:4068
