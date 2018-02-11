#!bin/bash

cur_usr=`basename ~/`
cur_path=$(cd "$(dirname "$0")"; pwd)
cur_sys=`cat /etc/*-release | sed -r "s/^ID=(.*)$/\\1/;tA;d;:A;s/^\"(.*)\"$/\\1/"`

# Stop the script when any Error occur
set -e

# Functions
Color_Error='\E[1;31m'
Color_Success='\E[1;32m'
Color_Res='\E[0m'

function echo_error(){
    echo -e "${Color_Error}${1}${Color_Res}"
}

function echo_success(){
    echo -e "${Color_Success}${1}${Color_Res}"
}

case ${cur_sys} in
    "ubuntu")
        sudo apt-get update
        sudo apt-get install -y libsdl2-dev libsdl2-image-dev libpcre3-dev libfreetype6-dev libglew-dev libglm-dev libboost-dev libpng12-dev
        sudo apt-get install -y ffmpeg
    ;;
    "centos")
        sudo yum install -y epel-release
        sudo yum install -y yum install -y gcc-c++ SDL2-devel SDL2_image-devel pcre-devel freetype-devel glew-devel glm-devel boost-devel libpng-devel
    ;;
esac

tar -zxvf ${cur_path}/Logstalgia/logstalgia-*.tar.gz -C ~/
cd ~/logstalgia-*

# Compile
./configure

sudo make
sudo make install

sudo rm -rf ~/logstalgia-*

echo_success 'Logstalgia Ready'
