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
	docker pull sqlinantes/blockchain-bootnode
	docker pull sqlinantes/blockchain-dashboard

	if [ ! -f ./names.json ]; then
		echo "[]" > names.json
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

	RUNNING_CONT=$(docker ps | wc -l)
	if [[ $RUNNING_CONT -gt 1 ]]; then
		echo -e "you have \e[1mrunning containers\e[0m. Please stop them to start the demo."
		exit 1
	fi

	if [[ ! $(which iw) ]]; then
		echo -e "\e[1miw command not found\e[0m, can't test Access Point compatibility"
		exit 1
	fi

	if [[ ! $(iw list | grep "* AP$") ]]; then
		echo -e "hardware \e[1mNOT COMPATIBLE\e[0m with access point"
		exit 1
	else
		echo -e "hardware \e[1mCOMPATIBLE\e[0m with access point"
	fi

	if [ ! -z "$2" ]; then
		echo "Starting the bundle..."
		cd docker-ap
		./docker_ap start $2
		# DHCP CONFIG
		docker exec ap-container sh -c "echo 'dhcp-host=b8:27:eb:2e:60:a7,chupi,192.168.7.61,12h' >> /etc/dnsmasq.conf"
		docker exec ap-container service dnsmasq restart
		cd ..
		docker-compose up -d
		docker exec bundle_ntp_1 sh -c "printf 'server 127.127.1.0 iburst\nfudge 127.127.1.0 stratum 10' >> /etc/ntp.conf"
		docker exec bundle_ntp_1 service ntp restart

    # Restore user rights
    # /!\ We are under "sudo"
    CUR_USER=${SUDO_USER:-${USER}}
    CUR_GROUP=`id -gn $CUR_USER`
    chown -R $CUR_USER:$CUR_GROUP .
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
