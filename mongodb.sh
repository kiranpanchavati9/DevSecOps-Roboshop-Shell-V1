#!/bin/bash

echo "Installing MongoDB..."

# Copy repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo

# Install MongoDB
dnf clean all
dnf makecache
dnf install -y mongodb-org

# Update bind IP
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

# Enable + Start service
systemctl enable mongod
systemctl restart mongod

# Status Check
systemctl status mongod
