#!/bin/bash

sudo service docker start

cd ~/Documents/blockchain-bootnode/

if [ ! -f ~/Bureau/genesis.json ];
then
	echo "~/Bureau/genesis.json does not exists, can't build."
	read a
	exit -1
fi

cp ~/Bureau/genesis.json ~/Documents/blockchain-bootnode/

sudo docker build -t blockchain-bootnode .

rm -f ~/Documents/blockchain-bootnode/genesis.json

echo "Press Enter To Quit..."

read b

