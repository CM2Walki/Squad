############################################################
# Dockerfile that builds a Squad Gameserver
############################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 403240
ENV STEAMAPP squad
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/CM2Walki/Squad

ENV STEAM_BETA_APP 774961
ENV STEAM_BETA_PASSWORD ""
ENV STEAM_BETA_BRANCH ""

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21-1+deb11u1 \
	# Add entry script
	&& wget "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& chmod 755 "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& chown "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/*

ENV PORT=7787 \
	QUERYPORT=27165 \
	RCONPORT=21114 \
	FIXEDMAXPLAYERS=80 \
	FIXEDMAXTICKRATE=50 \
	RANDOM=NONE

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 7787/udp \
	27165/tcp \
	27165/udp \
	21114/tcp \
	21114/udp
