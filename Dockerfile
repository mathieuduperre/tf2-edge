FROM ubuntu:latest
MAINTAINER Mathieu Duperre <mathieu.duperre@gmail.com>

RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get install -y wget lib32gcc1 lib32tinfo5 unzip nginx lib32gcc1 libc6-i386 wget lib32stdc++6

RUN apt-get install -y lib32gcc1 libc6-i386 wget lib32stdc++6 lib32tinfo5
RUN apt-get install -y libtinfo5:i386  libncurses5:i386 libcurl3-gnutls:i386

RUN useradd -ms /bin/bash steam
WORKDIR /home/steam
USER steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf /tmp/steamcmd_linux.tar.gz && \
    rm /tmp/steamcmd_linux.tar.gz

# Install TF2 once to speed up container startup
RUN ./steamcmd.sh +login anonymous +force_install_dir ./tf2 +app_update 232250 validate +quit

ENV TF2_HOSTNAME TeamFortress2 Source Dedicated Server
ENV PUBLIC_IP ""
ENV PRIVATE_IP ""
ENV STEAM_ACCOUNT_TOKEN ""

EXPOSE 27015/udp
EXPOSE 27015

USER root
RUN chmod 775 /root/.steam/sdk32/steamclient.so
RUN CHOWN steam:steam /root/.steam/sdk32/steamclient.so
RUN ln -s /root/tf2/bin/steamclient.so /root/.steam/sdk32/steamclient.so
USER steam
ADD ./tf2_entrypoint.sh tf2_entrypoint.sh

CMD ./tf2_entrypoint.sh
