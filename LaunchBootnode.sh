#!/bin/bash

echo "Si vous fermez cette fenêtre, Bootnode ne sera pas entièrement fonctionnel."


sudo service docker start

currentDir=$(pwd)

NJDir=~/Documents/blockchain-bootnode/NamesJSON

echo "Fatal" > $NJDir/enode.txt

cd $NJDir

pwd

node names.js ~/Documents/blockchain-dashboard/src/public/res/json/names.json &

cd $currentDir

sudo docker run -e NETWORKID="100" -v $(pwd)/genesis.json:/tmp/genesis.json -v $NJDir/enode.txt:/home/enode.txt -p 8090:80 -p 30303:30303 -p 8547:8547 --name bootnode blockchain-bootnode
