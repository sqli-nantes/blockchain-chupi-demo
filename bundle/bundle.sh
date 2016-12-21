#!/bin/bash

if [[ $# -eq 0 ]] || [ "$1" = "-h" ]; then
	echo "Usage : bundle -h|pull|start|stop|clean [interface]"
	exit 1
fi

#Check if sudo
if [ ! "$(id -u)" = "0" ]; then
	echo "You must be sudo to run this script"
	exit 1
fi

#Check if needed programs are installed
git --version >/dev/null 2>&1 || { echo >&2 "Git is not installed, abort..."; exit 1; }
docker --version >/dev/null 2>&1 || { echo >&2 "Docker is not installed, abort..."; exit 1; }
docker-compose --version >/dev/null 2>&1 || { echo >&2 "Docker-Compose is not installed, abort..."; exit 1; }

if [ "$1" = "pull" ]; then
	echo "Pulling sources and images..."
	if [ -d docker-ap ]; then
		cd docker-ap
		git pull
		cd ..
	else
		git clone https://github.com/sqli-nantes/docker-ap-chupi.git docker-ap
	fi	

	docker pull cloudwattfr/ntpserver
	docker pull abohssain/blockchain-bootnode
	docker pull abohssain/blockchain-dashboard

	if [ ! -f ./names.json ]; then
		echo "{}" > names.json
	fi

	if [ ! -f ./genesis.json ]; then
		printf "\n\n\e[1m\e[93mDon't forget to put your genesis.json beside this script!\e[0m\e[39m\n\n"
	fi

	if [ ! -f ./iptables_conf.sh ]; then
		echo "#!/bin/sh" > iptables_conf.sh
		chmod +x iptables_conf.sh
	fi
	cp iptables_conf.sh docker-ap/iptables_conf.sh
	
	
fi

if [ "$1" = "start" ]; then
	if [ ! -z "$2" ]; then
		echo "Starting the bundle..."
		cd docker-ap
		./docker_ap start $2
		# DHCP CONFIG
		docker exec ap-container sh -c "echo 'dhcp-host=b8:27:eb:2e:60:a7,chupi,192.168.7.61,12h' >> /etc/dnsmasq.conf"
		docker exec ap-container service dnsmasq restart
		cd ..
		docker-compose up -d
	else
		echo "You didn't told me which interface I have to use"
	fi
fi

if [ "$1" = "stop" ] && [ ! -z "$2" ]; then
	if [ ! -z "$2" ]; then
		echo "Stopping the bundle..."
		cd docker-ap
		./docker_ap stop $2
		cd ..
		docker-compose down
	else
		echo "You didn't told me which interface I have to use"
	fi
fi



if [ "$1" = "clean" ]; then
	echo "Deleting generated/downloaded files..."
	rm -rf docker-ap dhclient.conf
fi
