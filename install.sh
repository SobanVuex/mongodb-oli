#!/usr/bin/env bash

# Add repository key
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

# Add repository
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Update repositories
apt-get update

# Install mongodb
apt-get install -y mongodb-org

# Update configuration
curl -sL "http://git.io/vJg5n" | tee /etc/mongod.conf

# Make data directory if missing
test -d /srv/mongodb || install -d /srv/mongodb -o mongodb -g nogroup
test -d /var/lib/mongodb && rm -rf /var/lib/mongodb

# Restart mongod service
service mongod restart
