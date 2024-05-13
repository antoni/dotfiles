#!/usr/bin/env bash

sudo service apache2 stop
sudo apt purge --assume-yes apache2
sudo apt purge --assume-yes apache2-utils
sudo apt --assume-yes autoremove
sudo rm -rf /etc/apache2
sudo rm -rf /var/lib/apache2
sudo rm -rf /var/log/apache2
sudo rm -rf /var/www/html
