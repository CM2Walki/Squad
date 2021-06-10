#!/bin/bash
bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
				+force_install_dir "/home/steam/squad-dedicated/" \
				+app_update "${STEAMAPPID}" \
				+quit

# Change rcon port on first launch, because the default config overwrites the commandline parameter (you can comment this out if it has done it's purpose)
sed -i -e 's/Port=21114/'"Port=${RCONPORT}"'/g' "/home/steam/squad-dedicated/SquadGame/ServerConfig/Rcon.cfg"

bash "mv -R /home/steam/Steam/steamapps/common/Squad Dedicated Server/ /home/steam/squad-dedicated/"


bash "/home/steam/squad-dedicated/SquadGameServer.sh" \
			Port="${PORT}" \
			QueryPort="${QUERYPORT}" \
			RCONPORT="${RCONPORT}" \
			FIXEDMAXPLAYERS="${FIXEDMAXPLAYERS}" \
			FIXEDMAXTICKRATE="${FIXEDMAXTICKRATE}" \
			RANDOM="${RANDOM}"
bash