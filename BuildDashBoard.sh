#!/bin/bash

sudo service docker start

cd ~/Documents/blockchain-dashboard/

sudo docker build -t dashblock2 .

echo "Press Enter To Quit..."

read b

