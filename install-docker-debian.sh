#/usr/bin/env bash

# SET UP REPO
# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

# Add official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Use the following command to set up the repository:
echo \
	"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# update apt package index
sudo apt-get update

# INSTALL DOCKER ENGINE
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# test hello-world
sudo docker run hello-world

# Manage Docker as non-root
# Create the docker group.
sudo groupadd docker
# Add your user to the docker group.
sudo usermod -aG docker $USER
# Log out and log back in so that your group membership is re-evaluated.
# If you’re running Linux in a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.
# You can also run the following command to activate the changes to groups:
newgrp docker
#Verify that you can run docker commands without sudo.
docker run hello-world

# start on boot with systemd
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
