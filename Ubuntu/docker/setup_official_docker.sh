#!/bin/bash

# 移除旧版本
sudo apt-get -y remove docker docker-engine docker.io containerd runc
# 彻底清空
sudo apt-get -y purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# 安装依赖
sudo apt-get update
sudo apt-get -y install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release



# 添加官方 GPG 密钥
sudo rm -rf /etc/apt/keyrings/docker.gpg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 添加官方软件源
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# 允许非 root 用户使用 docker 命令
if grep -q "^docker:" /etc/group; then
  echo "Group 'docker' already exists."
else
  echo "Creating group 'docker'..."
  sudo groupadd docker
fi

sudo usermod -aG docker $USER
newgrp docker
docker run hello-world