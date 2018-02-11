############################################################
# Dockerfile that builds a Squad Gameserver
############################################################
FROM debian:stretch
MAINTAINER Walentin 'Walki' Lamonos <walentinlamonos@gmail.com>

# Install, update & upgrade packages
# Create user for the server
# This also creates the home directory we later need
RUN apt-get update && apt-get install -y \
        screen \
        lib32gcc1 \
        curl && \
        apt-get -y upgrade && \
        useradd -m steam

# Switch to user steam;
USER steam

# Create Directory for SteamCMD
# Download SteamCMD
# Extract and delete archive
# Run Steamcmd and install Squad
RUN mkdir -p /home/steam/steamcmd && cd /home/steam/steamcmd && \
        curl -o steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" && \
        tar zxf steamcmd_linux.tar.gz && \
        rm steamcmd_linux.tar.gz && \
        ./steamcmd.sh \
        +login anonymous \
        +force_install_dir /home/steam/squad-dedicated \
        +app_update 403240 validate \
        +quit

# Switch to root for the last commands
USER root

# Clean TMP, apt-get cache and other stuff to make the image smaller
RUN apt-get clean autoclean && apt-get autoremove -y && \
        rm -rf /var/lib/{apt,dpkg,cache,log}/

USER steam

ENV PORT=7787 QUERYPORT=27165 FIXEDMAXPLAYERS=80 RANDOM=NONE

# Set Entrypoint; Technically 2 steps: 1. Update server, 2. Start server
ENTRYPOINT ./home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/squad-dedicated +app_update 403240 +quit && \
        ./home/steam/squad-dedicated/SquadServer.sh Port=$PORT QueryPort=$QUERYPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM

# Expose ports
EXPOSE 7787 27165
