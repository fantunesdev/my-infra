######## VAULTCTL ########
sudo git clone https://github.com/fantunesdev/vaultctl /var/lib/vaultctl/
sudo chown fernando:fernando /var/lib/vaultctl/ -R
cd /var/lib/vaultctl/
poetry install
sudo cp /var/lib/vaultctl/vaultctl.sh /usr/bin/vaultctl
vaultctl --configure

######## VKV ########
sudo git clone https://github.com/fantunesdev/vkv /var/lib/vkv/
sudo chown fernando:fernando /var/lib/vaultctl/ -R
