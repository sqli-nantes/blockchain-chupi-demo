#!/bin/bash

echo -ne '\033]0;BOOTNODE\007'

echo "Si vous fermez cette fenêtre, Bootnode ne sera pas entièrement fonctionnel."

sudo service docker start

currentDir=$(pwd)

NJDir=~/Documents/blockchain-bootnode/NamesJSON

echo "Fatal" > $NJDir/enode.txt

cd $NJDir

pwd

if [ ! -z "$1" ]; then
	node names.js ~/Documents/blockchain-dashboard/src/public/res/json/names.json &
fi

cd $currentDir

sudo docker run -e NETWORKID="100" -v $(pwd)/genesis.json:/tmp/genesis.json -v $NJDir/enode.txt:/home/enode.txt -v ~/Documents/blockchain-dashboard/src/public/res/json/names.json:/home/NamesJSON/names.json -p 8081:8081 -p 8090:80 -p 30303:30303 -p 8547:8547 --name bootnode ${1:-blockchain-bootnode}
