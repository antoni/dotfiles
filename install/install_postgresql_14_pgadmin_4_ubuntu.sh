#!/usr/bin/env bash
set -ue

sudo apt update
sudo apt upgrade --assume-yes

# Add postgresql repository and key
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update again
sudo apt-get update

# Install pgadmin4
function install_pgadmin() {
	# Install the public key for the repository (if not done previously):
	sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
	# Create the repository configuration file:
	sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

	# Install for both desktop and web modes:
	sudo apt install pgadmin4 --assume-yes

	# Install for desktop mode only:
	# sudo apt install pgadmin4-desktop

	# Install for web mode only:
	# sudo apt install pgadmin4-web
}
install_pgadmin

# Install postgresql-13
sudo apt-get --assume-yes install postgresql

# Check version to see if it's correct
psql --Version

# Allow remote connections
# edit line #listen_addresses to listen_addresses = '*'
sudo vim /etc/postgresql/14/main/postgresql.conf
# change port to:
# port = 5450

# edit file
sudo vim /etc/postgresql/14/main/pg_hba.conf
# add line at the end (change 192.168.0.0/24 to your network or 0.0.0.0/0 to all)
host all all 192.168.0.0/24 md5
# FOR SSL: add line at the end (change 192.168.0.0/24 to your network or 0.0.0.0/0 to all)
hostssl all all 192.168.0.0/24 md5 clientcert=1

# Restart postgres
sudo systemctl restart postgresql

# Access psql to create users, databases and passwords
sudo --user postgres psql

# Add a stronger password to default postgres user
alter user postgres with encrypted password 'test'

# Create user
create user test with encrypted password 'test'

# OR a superuser
# CREATE ROLE your_username WITH LOGIN SUPERUSER CREATEDB CREATEROLE PASSWORD 'test';

# Create a database
sudo -u postgres psql -c 'CREATE DATABASE db_name2 WITH OWNER your_username;'

# Grant permissions to user on database
sudo -u postgres psql -c 'GRANT ALL PRIVILEGES ON DATABASE db_name TO your_username;'

# Read security tips here
# https://www.digitalocean.com/community/tutorials/how-to-secure-postgresql-against-automated-attacks
