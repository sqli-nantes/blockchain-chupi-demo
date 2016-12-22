#!/bin/sh

GATEWAY=192.168.7.1

# Dashboard
MODULE=172.17.0.5
PORT=8080
iptables -t nat -A PREROUTING -p tcp -d $GATEWAY --dport $PORT -j DNAT --to-destination $MODULE:$PORT -i wlp1s0
iptables -t nat -A POSTROUTING -p tcp -d $MODULE --dport $PORT -j SNAT --to-source $GATEWAY:$PORT -o eth0



# Bootnode
MODULE=172.17.0.4
PORT=8081
iptables -t nat -A PREROUTING -p tcp -d $GATEWAY --dport $PORT -j DNAT --to-destination $MODULE:$PORT -i wlp1s0
iptables -t nat -A POSTROUTING -p tcp -d $MODULE --dport $PORT -j SNAT --to-source $GATEWAY:$PORT -o eth0
PORT=30303
iptables -t nat -A PREROUTING -p tcp -d $GATEWAY --dport $PORT -j DNAT --to-destination $MODULE:$PORT -i wlp1s0
iptables -t nat -A POSTROUTING -p tcp -d $MODULE --dport $PORT -j SNAT --to-source $GATEWAY:$PORT -o eth0
PORT=8547
iptables -t nat -A PREROUTING -p tcp -d $GATEWAY --dport $PORT -j DNAT --to-destination $MODULE:$PORT -i wlp1s0
iptables -t nat -A POSTROUTING -p tcp -d $MODULE --dport $PORT -j SNAT --to-source $GATEWAY:$PORT -o eth0


# NTP
MODULE=172.17.0.3
PORT=123
iptables -t nat -A PREROUTING -p tcp -d $GATEWAY --dport $PORT -j DNAT --to-destination $MODULE:$PORT -i wlp1s0
iptables -t nat -A POSTROUTING -p tcp -d $MODULE --dport $PORT -j SNAT --to-source $GATEWAY:$PORT -o eth0
iptables -t nat -A PREROUTING -p udp -d $GATEWAY --dport $PORT -j DNAT --to-destination $MODULE:$PORT -i wlp1s0
iptables -t nat -A POSTROUTING -p udp -d $MODULE --dport $PORT -j SNAT --to-source $GATEWAY:$PORT -o eth0
