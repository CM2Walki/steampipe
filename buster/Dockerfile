############################################################
# Dockerfile that contains SteamCMD & SteamSDK
############################################################
FROM cm2network/steamcmd:root

ENV DLURL https://raw.githubusercontent.com/CM2Walki/steamsdk
ENV STEAMSDKDIR "${HOMEDIR}/steamsdk"
ENV BUILDERSCRIPTDIR "${STEAMSDKDIR}/sdk/tools/ContentBuilder/scripts"
ENV BUILDERCONTENTDIR "${STEAMSDKDIR}/sdk/tools/ContentBuilder/content"
ENV BUILDEROUTPUTDIR "${STEAMSDKDIR}/sdk/tools/ContentBuilder/output"
ENV VDFAPPBUILD "app_build_default.vdf" # The vdf steamcmd should call on container start

# Only Used if there are no scripts in ${BUILDERSCRIPTDIR}
ENV STEAMAPPID "22222"
ENV STEAMDEPOTID "22223"
ENV STEAMAPPBRANCH "" # Leave empty, if you want to manually set the branch on the partner page
ENV STEAMAPPBUILDESC "Docker CD upload"
ENV LOCALCONTENTPATH "*" # Directory to build in ContentRoot

# Used to auth with steamcmd
ENV STEAMUSER "anonymous"
ENV STEAMPASSWORD ""
ENV STEAMGUARDCODE "" # Only required once per container

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		unzip=6.0-23+deb10u1 \
		wget=1.20.1-1.1 \
	&& mkdir -p "${STEAMSDKDIR}" \
	&& wget "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& wget -qO- "https://partner.steamgames.com/downloads/steamworks_sdk.zip" -O steamworks_sdk.zip \
	&& unzip -q steamworks_sdk.zip -d "${STEAMSDKDIR}" \
	&& rm steamworks_sdk.zip \
	&& rm -r "${BUILDERSCRIPTDIR}/*" "${BUILDERCONTENTDIR}/*" "${BUILDEROUTPUTDIR}/*" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${STEAMSDKDIR}" "${HOMEDIR}/entry.sh" \
	&& rm -rf /var/lib/apt/lists/*

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

VOLUME [ "${BUILDERSCRIPTDIR}", \
	 "${BUILDERCONTENTDIR}", \
	 "${BUILDEROUTPUTDIR}" ]

CMD [ "bash", "entry.sh" ]
