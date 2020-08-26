############################################################
# Dockerfile that contains SteamCMD & SteamSDK
############################################################
FROM cm2network/steamcmd:root

ENV STEAMSDKDIR "${HOMEDIR}/steamsdk"

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		unzip=6.0-23+deb10u1 \
		wget=1.20.1-1.1 \
	&& mkdir -p "${STEAMSDKDIR}" \
    && wget -qO- "https://partner.steamgames.com/downloads/steamworks_sdk.zip" -O steamworks_sdk.zip \
	&& unzip -q steamworks_sdk.zip -d "${STEAMSDKDIR}" \
	&& rm steamworks_sdk.zip \
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

# Switch to user
USER ${USER}

WORKDIR ${STEAMCMDDIR}

VOLUME ${STEAMCMDDIR}
