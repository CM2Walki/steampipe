# (WIP) This is a WIP of the documentation
# Supported tags and respective `Dockerfile` links
  -	[`contentbuilder`, `latest` (*buster-contentbuilder/Dockerfile*)](https://github.com/CM2Walki/steampipe/blob/master/buster-contentbuilder/Dockerfile)

# What is SteamPipe?
SteamPipe is the game/application content system that powers Steam. SteamPipe includes the following features: Efficient and fast content delivery. Unlimited public and private "beta" branches, allowing multiple builds to be tested (Source: [developer.valvesoftware.com](https://partner.steamgames.com/doc/sdk/uploading)). If you are developing a game on Steam, this is the tool you use to upload new builds of your game to Steam.
 
# How to use this image
As of now, the image only supports the ContentBuilder of SteamPipe. Further SteamPipe features will be added in the future, as long as they don't directly require an installation of Steamworks SDK (which would be non-compliant with the SDK's developer agreement).

## Using ContentBuilder
**Use-Case: Upload build to a depot and/or deploy to a branch (CI/CD).**

The ContentBuilder image replicates a minimal directory structure of a Steamworks SDK installation, whilst actually only being dependent on a [SteamCMD](https://github.com/CM2Walki/steamcmd) installation. This image assumes that you already have depots and branches setup on [partner.steamgames.com](https://partner.steamgames.com). You will also require a seperate Steamworks account (e-mail Steam Guard) that has sufficient permissions to push to your steam depots. If you haven't completed any of these steps consult [the official documentation](https://partner.steamgames.com/doc/sdk/uploading).

**Initial one-time setup:**

Create required named volumes:
```console
$ docker volume create
$ docker volume create
$ docker volume create
$ docker volume create
```

Activate the SteamCMD installation, you will be asked to enter your e-mail Steam Guard once:
```console
$ docker run -it --rm cm2network/steampipe:contentbuilder bash /home/steam/steamcmd/steamcmd.sh +login [username] [password] +quit
```

### Configuration
**Environment Variables:**

Feel free to overwrite these environment variables, using -e (--env): 
```dockerfile
VDFAPPBUILD="app_build_default.vdf" (The vdf steamcmd should call on container start)
STEAMAPPBRANCH="" (Leave empty, if you want to manually set the branch on the partner page)
STEAMAPPBUILDESC="Docker CD upload" (Partner page build description)

STEAMAPPID="22222" (Only Used if there are no scripts in ${BUILDERSCRIPTDIR})
STEAMDEPOTID="22223" (Only Used if there are no scripts in ${BUILDERSCRIPTDIR})

CONTENTBUILDERDIR="${HOMEDIR}/steamsdk"
BUILDERSCRIPTDIR="${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/scripts"
BUILDERCONTENTDIR="${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/content"
BUILDEROUTPUTDIR="${CONTENTBUILDERDIR}/sdk/tools/ContentBuilder/output"
LOCALCONTENTPATH="*" (Directory to build inside ContentRoot)
```
