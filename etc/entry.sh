#!/bin/bash
if [ ! -z "$STEAM_BETA_BRANCH" ]
then
	echo "Loading Steam Beta Branch"
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
					+login anonymous \
					+app_update "${STEAM_BETA_APP}" \
					-beta "${STEAM_BETA_BRANCH}" \
					-betapassword "${STEAM_BETA_PASSWORD}" \
					+quit
else
	echo "Loading Steam Release Branch"
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
					+login anonymous \
					+app_update "${STEAMAPPID}" \
					+quit
fi

# Change rcon port on first launch, because the default config overwrites the commandline parameter (you can comment this out if it has done it's purpose)
sed -i -e 's/Port=21114/'"Port=${RCONPORT}"'/g' "${STEAMAPPDIR}/SquadGame/ServerConfig/Rcon.cfg"

bash "${STEAMAPPDIR}/SquadGameServer.sh" \
			Port="${PORT}" \
			QueryPort="${QUERYPORT}" \
			RCONPORT="${RCONPORT}" \
			FIXEDMAXPLAYERS="${FIXEDMAXPLAYERS}" \
			FIXEDMAXTICKRATE="${FIXEDMAXTICKRATE}" \
			RANDOM="${RANDOM}"
