Bundle Chupi Demo
===

Chupi is a demonstration of the blockchain Ethereum made by SQLI-Nantes, showed at the DevFest 2016. In order to make easier to launch this app, we made this bundle.

# Prerequisites

This demo was showed with:

* An Ubuntu 16.04 laptop with network card AP compatible;
* a Raspberry Pi 2 with a LED;
* an Android 5.0 smartphone.

_The bundle is related to the laptop. You may have to configure Chupi or AndJIM regarding to their repository README._

You need to install :

* Docker;
* Docker-Compose;
* Git.

Then you need some files not provided at the root directory : 
* genesis.json

# Demo

```
./bundle.sh pull
./bundle.sh start wlp1s0
# Connect Chupi to the AP "DockerAP" with passphrase in wlan_config.txt
# Start Chupi
# Connect android device (with AndroidJim app) to the AP "DockerAP" with passphrase in wlan_config.txt
# Do the demo
./bundle.sh stop wlp1s0
```

# Usage

## Bundle usage

`./bundle.sh -h|pull|start|stop|clean [interface]`

* `-h` display the usage
* `pull` download required sources and containers, create config files if does not exists
* `start` start the bundle in this order :
  - Docker-AP, the Wifi network manager, container named **ap-container**
  - NTPServer, the NTP server
  - Bootnode, the bootnode of the demo, container named **bootnode**
  - Dashblock, the UI logger of the demo, container named **dashblock**
* `stop` stop the bundle in the inverse order of start
*  `clean` delete some files

## Chupi start

You can connect to Chupi via SSH. It's IP will be **192.168.7.61**. One of the multiple ways to connect is `docker exec ap-container ssh pi@192.168.7.61`.

# Configuration

After a `./bundle pull`, you can customize your configuration.

## Wifi configuration

In the *docker-ap* directory, the file *wlan_config.txt* contains the informations relatives to the WIFI configuration.

* **SSID** : Name of the Wifi
* **PASSPHRASE** : Passphrase/Password of the Wifi

## Dashblock configuration

*names.json* contain a JSON-formated list of names/account tuple. Refer to Dashblock repository.

Example :

```json
[
  {"name":"foo","address":"0x1234"},
  {"name":"bar","address":"0x5678"}
]
```

## Bootnode configuration

*genesis.json* contains the blockchain configuration. Refer to Bootnode repository.

Example :

```json
{
    "nonce": "0x0000000000000042",
    "timestamp": "0x0",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "extraData": "S Q L I blockchain",
    "gasLimit": "0x8000000",
    "difficulty": "0x20000",
    "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "coinbase": "0x0000000000000000000000000000000000000042",
    "alloc": {     }
}
```

## IP Tables configuration

Add in the *iptables_conf.sh* script the iptables lines you want to launch at the start of the bundle.

## DHCP fixed address

The *bundle.sh* script fix the IP of Chupi with its MAC address. If you want to change it, look for `# DHCP CONFIG` commentary in order to find the line where to replace the MAC address.
