# Adding user to sudoers
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER``

# Mounting metropolis2
# This needs to be done every restart
mkdir -p /media/scratch.metropolis2
sudo chmod -R 777 /media/scratch.metropolis2
sudo mount -t cifs -o "vers=2.0,username=achafale,dom=nvidia.com,dir_mode=0777,file_mode=0777,mfsymlinks" //dc2-cdot49-sw-svm02/scratch.metropolis2 /media/scratch.metropolis2

# Setup ngc access
git clone ssh://git@gitlab-master.nvidia.com:12051/tlt/ngc-collaterals.git
rm -rvf ngc-collaterals
wget --content-disposition https://api.ngc.nvidia.com/v2/resources/nvidia/ngc-apps/ngc_cli/versions/3.33.0/files/ngccli_linux.zip -O ngccli_linux.zip && unzip ngccli_linux.zip
chmod u+x ngc-cli/ngc
echo "export PATH=\"\$PATH:$(pwd)/ngc-cli\"" >> ~/.bash_profile && source ~/.bash_profile
echo "AT THIS POINT, GET YOUR NGC API KEY FOR THE SUBSEQUENT NGC SETUP"
ngc config set
rm -f ngccli_linux.zip

echo "AT THIS POINT, GET YOUR NGC API KEY FOR THE SUBSEQUENT NVCR.IO DOCKER SETUP"
docker login --username '$oauthtoken' nvcr.io 

# Verifying CUDA

echo "export PATH=\"/usr/local/cuda-12.3/bin\${PATH:+:\${PATH}}\"" >> ~/.bash_profile 
echo "export LD_LIBRARY_PATH=\"/usr/local/cuda-12.3/lib64\${LD_LIBRARY_PATH:+:\${LD_LIBRARY_PATH}}\"" >> ~/.bash_profile 
source ~/.bash_profile

nvcc --version
nvidia-smi

# Disabling MIG in case it was enabled by default
# nvidia-smi -mig 0

# git clone https://github.com/nvidia/cuda-samples
# cd cuda-samples/Samples/1_Utilities/deviceQuery
# make
# ./deviceQuery
