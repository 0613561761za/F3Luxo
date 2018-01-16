#!/bin/bash
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
BlueF='\e[1;34m'

# go to root
cd

FREE=`free -m | grep "buffers/cache" | awk '{print $3}'`
SWAP=`free -m | grep "Swap" | awk '{print $3}'`
UP=`uptime`

echo $FREE
echo $SWAP
echo $UP
echo -e $yellow""
echo ""
echo "#######################################################"
echo "#                SCRYPT MBAH SHONDONG                 #"
echo "#            http://www.mbahshondong.com              #"
echo "#-----------------------------------------------------#"
echo "#                     HAWOK JOZZ                      #"
echo "#      https://www.facebook.com/groups/pokoemelu      #"
echo "#-----------------------------------------------------#"
echo "#         [== INTERNET GRATIS SAK MODARRE ==]         #"
echo "#######################################################"
echo -e $white""
echo ""
echo "--------------------------------------------------------" 

cd ~/
