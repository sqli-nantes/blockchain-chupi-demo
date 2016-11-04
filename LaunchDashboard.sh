#!/bin/bash

sudo service docker start

sudo docker run -d -p 8080:8080 -p 80:80 -p 443:443 -v /home/user/Documents/blockchain-bootnode/NamesJSON/names.json:/home/httpserver/src/public/res/json/names.json --name dashblock dashblock

echo "Press Enter To Quit..."

read b
