#!/bin/bash

yes "" | ./LaunchDashboard.sh

gnome-terminal -x ./DashBlockChrome.sh

#gnome-terminal -x  ./MineOnly.sh 10

#gnome-terminal -x ./ChuPi.sh

./LaunchBootnode.sh 
