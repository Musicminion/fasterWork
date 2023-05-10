#!/bin/bash

# 检查 lsb-release 包是否已安装，如果没有安装，则安装它
if ! dpkg -s lsb-release >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y lsb-release
fi

# 备份当前源列表
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 获取系统架构信息
ARCH=$(uname -m)

# 根据系统架构信息，选择添加的源
if [ ${ARCH} = "x86_64" ]; then
    # 更新软件源为阿里镜像源
    sudo tee /etc/apt/sources.list << EOF
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs) main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-updates main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-security main restricted universe multiverse
EOF
    # 更新软件包列表
    sudo apt update
else
    # 更新软件源为阿里镜像源
    sudo tee /etc/apt/sources.list << EOF
    deb http://mirrors.aliyun.com/ubuntu-ports/ $(lsb_release -cs) main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu-ports/ $(lsb_release -cs)-updates main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu-ports/ $(lsb_release -cs)-backports main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu-ports/ $(lsb_release -cs)-security main restricted universe multiverse
EOF
    # 更新软件包列表
    sudo apt update
fi

echo "源已经更改为阿里镜像源。"
