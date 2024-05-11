# Install CUDA

chmod 777 $HOME

sudo apt-get install linux-headers-$(uname -r)
distro=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
sudo apt-key del 7fa2af80
wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit
sudo apt-get -y install cuda-drivers
sudo rm -f cuda-keyring_1.1-1_all.deb

# Install docker
sudo apt-get -y install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
sudo docker run hello-world

# Install nvidia-docker
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Install misc packages
sudo apt-get install -y vim openssh-server default-jre git-all software-properties-common unzip

# Install Python
sudo apt install -y python3-pip python3.8 python3.8-venv python-is-python3

echo "THE SYSTEM WILL NOW REBOOT TO FINISH THE SETUP, PLEASE LOG BACK IN TO VERIFY EVERYTHING WORKED"
sudo reboot
