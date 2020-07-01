DIST=$(lsb_release -c |awk '{print $NF}')
# For docker
sudo apt update
sudo apt install python-pip apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $DIST stable" 
sudo apt update
sudo apt install docker-ce
sudo usermod -aG docker $USER  && newgrp docker # add user to the docker grou

# For nvidia-docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit nvidia-docker2
sudo systemctl restart docker
pip install docker-compose

# change /etc/docker/daemon.json
sudo cp /etc/docker/daemon.json /etc/docker/backup_daemon.json
sudo cp sample_daemon.json /etc/docker/daemon.json
echo 'The original /etc/docker/daemon.json file is backed up as /etc/docker/backup_daemon.json'
sudo pkill -SIGHUP dockerd