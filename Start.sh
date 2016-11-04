#!/bin/bash

yes "" | ./LaunchDashboard.sh

gnome-terminal -x ./DashBlockChrome.sh

#gnome-terminal -x (sleep 10 && ./MineOnly.sh)

./LaunchBootnode.sh 
