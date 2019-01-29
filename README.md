# Team fortress 2 docker image

-------------------------------------------------------------------------------------------------------------------
## Quick start:

To run a game, just execute, You can easily start one instance by simply doing:

docker pull grido/tf2-edge

docker run -p 27015:27015 -p 27015:27015/udp grido/tf2-edge


-------------------------------------------------------------------------------------------------------------------
## How to build docker image

useful if you need to update
To build the docker image locally by using this git repo:

git clone https://github.com/mathieuduperre/tf2-edge.git

cd tf2-edge

docker build -t grido/tf2-edge .

docker run -p 27015:27015 -p 27015:27015/udp grido/tf2-edge



----------------------------------------------------------------------------------------------------------------------------------

## How the docker was built. 

You should not need that, these are just notes.

docker pull ubuntu

docker run --name tf2-edge -it ubuntu:latest bash

dpkg --add-architecture i386

apt-get update

apt-get install -y lib32gcc1 libc6-i386 wget lib32stdc++6 lib32tinfo5

apt-get install  libtinfo5:i386  libncurses5:i386 libcurl3-gnutls:i386

cd root

wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz

tar -xvzf steamcmd_linux.tar.gz

./steamcmd.sh +login anonymous +force_install_dir ./tf2 +app_update 232250 +quit

cd tf2

mkdir /root/.steam/sdk32

ln -s /root/tf2/bin/steamclient.so /root/.steam/sdk32/steamclient.so

 ./srcds_run -game tf -console +sv_pure 1 +randommap +maxplayers 24


