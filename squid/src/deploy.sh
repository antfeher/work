#!/bin/bash

echo "CONFIGURING TOR..."

cat <<EOF >> /etc/tor/torrc

ExitPolicy reject *:* # no exits allowed
ExitPolicy reject6 *:* # no exits allowed

EOF



echo "CONFIGURING PRIVOXY..."

sed -i '1,1230 s/^/#/' /etc/privoxy/config

cat <<EOF >> /etc/privoxy/config

forward-socks4a / 127.0.0.1:9050 .
confdir /etc/privoxy
logdir /var/log/privoxy
actionsfile default.action # Main actions file
actionsfile user.action # User customizations
filterfile default.filter

logfile logfile

debug 4096 # Startup banner and warnings
debug 8192 # Errors — *we highly recommended enabling this*

user-manual /usr/share/doc/privoxy/user-manual
listen-address 127.0.0.1:8118
toggle 1
enable-remote-toggle 0
enable-edit-actions 0
enable-remote-http-toggle 0
buffer-limit 4096

EOF



echo "CONFIGURING SQUID..."

mkdir /etc/squid/acl
echo ".example.com" >> /etc/squid/acl/tor-acl

cat <<EOF >> /etc/squid/squid.conf

acl redirect-to-tor dstdomain "/etc/squid/acl/tor-acl"

cache_peer 127.0.0.1 parent 8118 0 no-query proxy-only default name=tor-server
never_direct allow redirect-to-tor
always_direct allow all !redirect-to-tor

EOF

