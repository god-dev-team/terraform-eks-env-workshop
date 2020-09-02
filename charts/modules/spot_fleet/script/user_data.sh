#!/bin/bash -xe
export PATH=/usr/local/bin:$PATH

yum -y --security update &&

yum install -y java-1.8.0-openjdk.x86_64 &&

/usr/sbin/alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java || true &&
/usr/sbin/alternatives --set javac /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/javac || true &&
yum remove java-1.7 || true &&

yum install git jq curl -y &&
easy_install pip &&
pip install awscli 

# #Install npm
# yum install -y gcc-c++ make -y
# curl -sL https://rpm.nodesource.com/setup_11.x | sudo -E bash - 
# yum install nodejs -y

#Install openjdk-13_
wget https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz

tar -xvf openjdk-13_linux-x64_bin.tar.gz
mv jdk-13 /opt/
tee /etc/environment <<EOF
export JAVA_HOME=/opt/jdk-13/
export PATH=$PATH:/opt/jdk-13/bin
EOF

source /etc/environment

### install docker
echo "install docker" >> /tmp/userdata.log
yum update -y
yum install -y docker
service docker start

## install docker-compose
echo "install docker-compose" >> /tmp/userdata.log
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "update permissions for jenkins user" >> /tmp/userdata.log
usermod -a -G docker ec2-user
### for master server
useradd jenkins
usermod -a -G docker jenkins

# ###Bumpversion
# pip install --upgrade bumpversion

# ###npm cli
# npm install -g npm-cli-login


echo "add ssh key to user Jenkins" >> /tmp/userdata.log
## set jenkins ssh key
echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> /home/ec2-user/.ssh/known_hosts
