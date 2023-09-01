#!/usr/bin/env bash

#Script will Configure NixOS as well as wazuh agent
#Create directories
drawline
echo "Preparing Environment..."
drawline

mkdir /var/log/remote_logs
mkdir /etc/nixos/WazuhDocker

#Setup log clearing script
cp Scripts/clear_logs.sh /var/log/remote_logs/clear_logs.sh
chmod +x /var/log/remote_logs/clear_logs.sh

#Upload nixos config
rm /etc/nixos/configuration.nix
cp ConfigFiles/configuration.nix /etc/nixos/configuration.nix

#Rebuild system
nixos-rebuild switch

#Copy files for Wazuh Agent Docker image
cp ConfigFiles/Dockerfile /etc/nixos/WazuhDocker/Dockerfile
cp ConfigFiles/ossec.conf /etc/nixos/WazuhDocker/ossec.conf
cp Scripts/entrypoint.sh /etc/nixos/WazuhDocker/entrypoint.sh

echo "DONE!"

drawline
echo "Change password for SmartechNixAdmin"
drawline

passwd SmartechNixAdmin

drawline
echo "Configure Wazuh Agent"
drawline

#Setup config file for Wazuh Agent 
OSSEC="/etc/nixos/WazuhDocker/ossec.conf"
echo "Configure Wazuh:"
isok=true
while $isok
do 
    read -p "Enter Wazuh Manager IP Address: " ipaddress
    read -p "Enter name for Wazuh Agent: " wazuhagentname
    read -p "Enter group name for Wazuh Agent: " wazuhagentgroup
    read -p "Those are correct? [Y/N]: " yesorno
    if [ "$yesorno" == "Y" ] || [ "$yesorno" == "y" ];
    then
        isok=false
    fi
done

#Replace IP Address in ossec.conf
if [[ "ADDRESOFMANAGER" != "" && $ipaddress != "" ]]; then
  sed -i "s/ADDRESOFMANAGER/$ipaddress/" $OSSEC
fi

#Replace Host Name in ossec.conf
if [[ "NAMEOFAGENT" != "" && $wazuhagentname != "" ]]; then
  sed -i "s/NAMEOFAGENT/$wazuhagentname/" $OSSEC
fi

#Replace Group Name in ossec.conf
if [[ "NAMEOFWAZUHGROUP" != "" && $wazuhagentgroup != "" ]]; then
  sed -i "s/NAMEOFWAZUHGROUP/$wazuhagentgroup/" $OSSEC
fi

#Create Volume for Wazuh Data
docker volume create wazuhvolume

#Build and Run Conteiner
cd /etc/nixos/WazuhDocker/
docker build -t wazuh-agent-container .
docker run -d --privileged --restart unless-stopped --network host -v /var/log/remote_logs:/var/log/remote_logs -v wazuhvolume:/var/ossec wazuh-agent-container

echo "All Done"

drawline
echo "Remember to install and configure Twingate connectors!!!!!"
drawline
