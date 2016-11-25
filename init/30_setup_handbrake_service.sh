#!/bin/bash
echo "Downloading bc"
wget http://mirrors.kernel.org/ubuntu/pool/main/b/bc/bc_1.06.95-2_amd64.deb

echo "Installing bc"
dpkg -i bc_1.06.95-2_amd64.deb
rm bc_1.06.95-2_amd64.deb
rm -f /tmp/handbrake-cli.lock

echo "Downloading h265ize"
wget -v -O /scripts/h265ize 'https://raw.githubusercontent.com/FallingSnow/h265ize/v0.2.1/h265ize'

if [ ! -f /config/handbrake-cli.cfg ];then
	echo "Downloading default handbrake-cli config"
	wget -v -O /config/handbrake-cli.cfg 'https://raw.githubusercontent.com/robshad/handbrake-cli/master/handbrake-cli.cfg'
fi


echo "Setting file permissions"
chmod +x /scripts/h265ize
chown -v -R abc:abc /scripts
chmod -v +x /scripts/handbrake
chmod -v +x /scripts/process-folder
mkdir -p /config/logs
mkdir -p /output/originals

crontab -l | { cat; echo "*/5 * * * * /scripts/process-folder"; } | crontab -
