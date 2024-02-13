############################################################
# Dockerfile that contains SteamCMD & SteamPipe-Contentbuilder
############################################################
FROM cm2network/steamcmd:root

ENV DLURL https://raw.githubusercontent.com/CM2Walki/steampipe
ENV CONTENTBUILDERDIR "${HOMEDIR}/steamsdk"
ENV BUILDERSCRIPTDIR "${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/scripts"
ENV BUILDERCONTENTDIR "${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/content"
ENV BUILDEROUTPUTDIR "${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/output"

# The vdf steamcmd should call on container start
ENV VDFAPPBUILD "app_build_default.vdf"

# Only Used if there are no scripts in ${BUILDERSCRIPTDIR}
ENV STEAMAPPID "22222"
ENV STEAMDEPOTID "22223"
# Leave empty, if you want to manually set the branch on the partner page
ENV STEAMAPPBRANCH ""
ENV STEAMAPPBUILDESC "Docker CD upload"
# Directory to build in ContentRoot
ENV LOCALCONTENTPATH "*"
 
# Used to auth with steamcmd
ENV STEAMUSER "anonymous"
ENV STEAMPASSWORD ""
# Only required once per container
ENV STEAMGUARDCODE ""

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21.3-1+b2 \
	&& mkdir -p "${CONTENTBUILDERDIR}" "${BUILDERSCRIPTDIR}" "${BUILDERCONTENTDIR}" "${BUILDEROUTPUTDIR}" \
	&& wget -q "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${CONTENTBUILDERDIR}" "${HOMEDIR}/entry.sh" \
	&& rm -rf /var/lib/apt/lists/*

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

VOLUME [ "${BUILDERSCRIPTDIR}", \
	 "${BUILDERCONTENTDIR}", \
	 "${BUILDEROUTPUTDIR}" ]

CMD [ "bash", "entry.sh" ]
