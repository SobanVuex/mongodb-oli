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

# Check directories
test -d /srv/mongodb || install -d /srv/mongodb -o mongodb -g nogroup
test -d /var/log/mongodb || install -d /var/log/mongodb -o mongodb -g nogroup 
test -d /var/lib/mongodb && rm -rf /var/lib/mongodb

# Check permissions
test "$(stat -c %U:%G /var/log/mongodb)" = "mongodb:mongodb" || chown -R mongodb:nogroup /var/log/mongodb
test "$(stat -c %U:%G /srv/mongodb)" = "mongodb:mongodb" || chown -R mongodb:nogroup /srv/mongodb

# Restart mongod service
service mongod restart
