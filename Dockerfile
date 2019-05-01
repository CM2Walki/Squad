############################################################
# Dockerfile that builds a Squad Gameserver
############################################################
FROM cm2network/steamcmd
LABEL maintainer="walentinlamonos@gmail.com"

# Run Steamcmd and install Squad
RUN set -x \
        && ./home/steam/steamcmd/steamcmd.sh \
        +login anonymous \
        +force_install_dir /home/steam/squad-dedicated \
        +app_update 403240 validate \
        +quit

ENV PORT=7787 QUERYPORT=27165 RCONPORT=21114 FIXEDMAXPLAYERS=80 RANDOM=NONE

VOLUME /home/steam/squad-dedicated

# Set Entrypoint; Technically 2 steps: 1. Update server, 2. Start server
ENTRYPOINT ./home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/squad-dedicated +app_update 403240 +quit && \
        ./home/steam/squad-dedicated/SquadGameServer.sh Port=$PORT QueryPort=$QUERYPORT RCONPORT=$RCONPORT FIXEDMAXPLAYERS=$FIXEDMAXPLAYERS RANDOM=$RANDOM

# Expose ports
EXPOSE 7787 27165 21114
