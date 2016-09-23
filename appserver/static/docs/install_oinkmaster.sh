#!/bin/bash
sudo apt-get -y install oinkmaster
mkdir /etc/oinkmaster
cat >/etc/oinkmaster/oinkmaster.conf <<EOF
# Suricata Emerging Threats
url = http://rules.emergingthreats.net/open/suricata/emerging.rules.tar.gz
EOF
oinkmaster -C /etc/oinkmaster/oinkmaster.conf -o /etc/suricata/rules
kill -USR2 $(ps aux | grep '[s]uricata' | awk '{print $2}')
# kill -USR2 $(ps aux | grep '[s]uricata' | awk '{print $2}')
# User should add to Crontab
#
# 55 5 * * * root ( oinkmaster -C /etc/oinkmaster/oinkmaster.conf -o /etc/suricata/rules; sleep 5; kill -USR2 $(ps aux | grep '[s]uricata' | awk '{print $2}') )
