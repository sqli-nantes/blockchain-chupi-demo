#!/bin/bash

sudo docker stop bootnode
sudo docker rm bootnode

echo "Bootnode stopped..."

read a
