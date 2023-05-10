#!/bin/bash

# 检查 lsb-release 包是否已安装，如果没有安装，则安装它
if ! dpkg -s lsb-release >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y lsb-release
fi

# 备份当前源列表
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 更新软件源为上海交通大学镜像站的源
sudo tee /etc/apt/sources.list << EOF
deb https://mirrors.sjtug.sjtu.edu.cn/ubuntu/ $(lsb_release -cs) main restricted universe multiverse
deb https://mirrors.sjtug.sjtu.edu.cn/ubuntu/ $(lsb_release -cs)-updates main restricted universe multiverse
deb https://mirrors.sjtug.sjtu.edu.cn/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse
deb https://mirrors.sjtug.sjtu.edu.cn/ubuntu/ $(lsb_release -cs)-security main restricted universe multiverse
EOF

# 更新软件包列表
sudo apt update

echo "源已经更改为上海交通大学镜像站的源。"
