#!/bin/bash
set -x
echo "++++++++++++++++++++++[init system]"
sudo apt update
sudo apt install python-pip git apt-transport-https ca-certificates curl software-properties-common -y

echo "++++++++++++++++++++++[install ansible | Docker]"
sudo pip install -U awscli boto3
sudo apt-add-repository -y ppa:ansible/ansible-2.6
sudo apt -y install ansible
sudo echo -e 'localhost     ansible_connection=local' > /etc/ansible/hosts

echo "添加docker官方GPG密钥"
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
echo "添加存储库"
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

echo "安装指定版本"
sudo apt install docker-ce=18.06.1~ce~3-0~ubuntu -y
[ ! $? -eq 0 ] && exit 10
sudo usermod -aG docker ubuntu
sudo systemctl restart docker && sudo systemctl enable docker
echo "++++++++++++++++++++++安装成功+++++++++++++++++++++"
docker info

sudo snap remove amazon-ssm-agent
sudo apt -y autoremove --purge snapd 
