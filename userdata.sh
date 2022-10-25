#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y apache2 php
sudo apt-get install -y php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php7.4-xml php7.4-zip php7.4-json php7.4-mbstring php7.4-ldap php7.4-bz2 nfs-common
sudo rm -f /var/www/html/index.html

sleep 5m

sudo echo "${efs-id}:/ /var/www/html/ nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0" >> /etc/fstab
sudo mount -a

wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz
tar -zxvf glpi-10.0.2.tgz
sudo chown -R www-data.www-data glpi
sudo cp -Rpv glpi/* /var/www/html/
rm -rf glpi*
systemctl restart apache2
echo "Instalacao terminada"