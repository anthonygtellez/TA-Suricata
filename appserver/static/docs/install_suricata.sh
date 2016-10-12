#!/bin/bash
apt update
preinstall="sudo apt-get -y install libpcre3 libpcre3-dbg libpcre3-dev \
build-essential autoconf automake libtool libpcap-dev libnet1-dev \
libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libcap-ng-dev libcap-ng0 \
make libmagic-dev libjansson-dev libjansson4 pkg-config"
${preinstall}
wget "http://www.openinfosecfoundation.org/download/suricata-3.1.tar.gz"
### Download Suricata 3.1 and configure directories
tar -xzf suricata-3.1.tar.gz
configure="suricata-3.1/configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var "
${configure}
### Compile from Source
make
make install-full
ldconfig

### Enable Emerging Threats
sudo cp classification.config /etc/suricata
sudo cp reference.config /etc/suricata
sudo cp suricata.yaml /etc/suricata

### Echo Success to user and prompt to start against interface
echo="suricata is now ready to use, run as a daemon against an interface:"
echo="sudo suricata -c /etc/suricata/suricata.yaml -i eth0 -D"
