#!/bin/bash

# Are there scripts in the directory?
# This is done on entry to provide bind mount support
if [ ! "$( ls -A "${BUILDERSCRIPTDIR}" )" ]; then
	# There are no scripts, download the default ones
	wget -qO- "${DLURL}/master/etc/app_build_default.vdf" -O "${BUILDERSCRIPTDIR}/app_build_default.vdf"
	wget -qO- "${DLURL}/master/etc/depot_build_default.vdf" -O "${BUILDERSCRIPTDIR}/depot_build_default.vdf"

	# Replace variables in app_build.vdf
	sed -i -e 's|{{STEAMAPPID}}|'"${STEAMAPPID}"'|g' \
		-e 's|{{STEAMDEPOTID}}|'"${STEAMDEPOTID}"'|g' \
		-e 's|{{STEAMAPPBUILDESC}}|'"${STEAMAPPBUILDESC}"'|g' \
		"${BUILDERSCRIPTDIR}/app_build_default.vdf"

	# Replace variables in depot_build.vdf
	sed -i -e 's|{{STEAMDEPOTID}}|'"${STEAMDEPOTID}"'|g' \
		-e 's|{{BUILDERCONTENTDIR}}|'"${BUILDERCONTENTDIR}"'|g' \
		-e 's|{{LOCALCONTENTPATH}}|'"${LOCALCONTENTPATH}"'|g' \
		"${BUILDERSCRIPTDIR}/depot_build_default.vdf"

	# Insert FileExclusions at the end of file
	IN="${FILEEXCLUSIONS}"
	FileExclusionsSplit=(${IN//;/ })

	if [ ${#FileExclusionsSplit[@]} -gt 0 ]; then
		for i in "${FileExclusionsSplit[@]}"; do
			sed -i "\$i\        \"FileExclusion\" \"$i\"" "${BUILDERSCRIPTDIR}/depot_build_default.vdf"
        	done
	fi
fi

sed -i "/\"setlive\"/c\        \"setlive\" \"${STEAMAPPBRANCH}\"" "${BUILDERSCRIPTDIR}/${VDFAPPBUILD}"

bash "${STEAMCMDDIR}/steamcmd.sh" +login "${STEAMUSER}" "${STEAMPASSWORD}" "${STEAMGUARDCODE}" \
					+run_app_build -desc "${STEAMAPPBUILDESC}" "${BUILDERSCRIPTDIR}/${VDFAPPBUILD}" \
					+quit
