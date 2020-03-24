#!/bin/sh

#systemctl restart systemd-sysusers
systemd-sysusers

mkdir -p /var/lib/consul
chown consul:consul /var/lib/consul
chmod 750 /var/lib/consul
