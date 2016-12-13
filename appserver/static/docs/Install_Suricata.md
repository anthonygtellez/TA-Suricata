# Quick Install of Suricata for Ubuntu

## Pre-install Requirements:

```
sudo apt-get -y install libpcre3 libpcre3-dbg libpcre3-dev \
build-essential autoconf automake libtool libpcap-dev libnet1-dev \
libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libcap-ng-dev libcap-ng0 \
make libmagic-dev libjansson-dev libjansson4 pkg-config
```

### IPS libraries
```
sudo apt-get -y install libnetfilter-queue-dev libnetfilter-queue1 libnfnetlink-dev libnfnetlink0
```

### Download Suricata 3.1 (substitue version)
```
VER=3.1.1
wget "http://www.openinfosecfoundation.org/download/suricata-$VER.tar.gz" 
tar -xvzf "suricata-$VER.tar.gz" 
cd "suricata-$VER"
```

### Compile & Install Engine

### Install with IDS capabilites
```
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
```

### Install with IPS capabilites
```
./configure --enable-nfqueue --prefix=/usr --sysconfdir=/etc --localstatedir=/var
```

### Install with full rules (emerging threats)
```
make
sudo make install-full
sudo ldconfig
```

### Create /var/log directory & /etc directory
```
sudo mkdir /var/log/suricata
sudo mkdir /etc/suricata

sudo cp classification.config /etc/suricata
sudo cp reference.config /etc/suricata
sudo cp suricata.yaml /etc/suricata
```

### Run Suricata
```
sudo suricata -c /etc/suricata/suricata.yaml -i eth0
```

### Run Suricata as a daemon
```
sudo suricata -c /etc/suricata/suricata.yaml -i eth0 -D
```

### Install OinkMaster
```
sudo apt-get -y install oinkmaster
```

### Create Directory & Configfile for OinkMaster
```
mkdir /etc/oinkmaster
touch /etc/oinkmaster/oinkmaster.conf
```

### Configfile for OinkMaster
```
# Suricata Emerging Threats
url = http://rules.emergingthreats.net/open/suricata/emerging.rules.tar.gz
```

### Run OinkMaster to update Suricata Rules & Restart Suricata
```
oinkmaster -C /etc/oinkmaster/oinkmaster.conf -o /etc/suricata/rules
kill -USR2 $(ps aux | grep '[s]uricata' | awk '{print $2}')
```

### Edit Crontab to update daily:
```
crontab -e 

55 5 * * * root ( oinkmaster -C /etc/oinkmaster/oinkmaster.conf -o /etc/suricata/rules; sleep 5; kill -USR2 $(ps aux | grep '[s]uricata' | awk '{print $2}') )
```
