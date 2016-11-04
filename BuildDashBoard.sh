#!/bin/bash

sudo service docker start

cd ~/Documents/blockchain-dashboard/

sudo docker build -t dashblock .

echo "Press Enter To Quit..."

read b

