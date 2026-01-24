#!/usr/bin/env bash
set -euo pipefail

# System update
sudo apt update
sudo apt upgrade -y

# Prerequisites
sudo apt install -y curl ca-certificates gnupg lsb-release

# PostgreSQL APT repo and key (apt-key replacement)
sudo install -d -m 0755 /etc/apt/keyrings

curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc |
	sudo gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg

echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/postgresql.gpg] \
  http://apt.postgresql.org/pub/repos/apt \
  $(lsb_release -cs)-pgdg main" |
	sudo tee /etc/apt/sources.list.d/pgdg.list >/dev/null

# pgAdmin APT repo and key
curl -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub |
	sudo gpg --dearmor -o /etc/apt/keyrings/pgadmin.gpg

echo \
	"deb [signed-by=/etc/apt/keyrings/pgadmin.gpg] \
  https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) \
  pgadmin4 main" |
	sudo tee /etc/apt/sources.list.d/pgadmin4.list >/dev/null

# Update after adding repositories
sudo apt update

# Install PostgreSQL 16 and pgAdmin
sudo apt install -y postgresql-16 pgadmin4

# Verify PostgreSQL version
psql --version

# PostgreSQL configuration
PG_VER=16
PG_CONF_DIR="/etc/postgresql/${PG_VER}/main"

echo "Edit ${PG_CONF_DIR}/postgresql.conf"
echo "Set: listen_addresses = '*'"
echo "Set: port = 5450"
sudo vim "${PG_CONF_DIR}/postgresql.conf"

echo "Edit ${PG_CONF_DIR}/pg_hba.conf"
echo "Add at end (adjust CIDR as needed):"
echo "host    all all 192.168.0.0/24 md5"
echo "hostssl all all 192.168.0.0/24 md5 clientcert=1"
sudo vim "${PG_CONF_DIR}/pg_hba.conf"

# Restart PostgreSQL
sudo systemctl restart postgresql

# Open psql
sudo -u postgres psql
