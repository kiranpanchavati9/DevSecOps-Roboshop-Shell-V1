#!/bin/bash
if [ "$EUID" -ne 0 ]; then
  sudo bash "$0" "$@"
  exit
fi

echo "Installing MongoDB..."

cp mongo.repo /etc/yum.repos.d/mongo.repo

rpm --import https://www.mongodb.org/static/pgp/server-7.0.asc

dnf clean all
dnf makecache
dnf install -y mongodb-org mongodb-org-server

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongodb.conf

systemctl enable mongod
systemctl restart mongod

echo "MongoDB installed successfully!"
systemctl status mongod --no-pager
