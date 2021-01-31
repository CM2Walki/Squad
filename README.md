[![](https://img.shields.io/codacy/grade/482dfa40623d4507b592c8b22d2b7ca0.svg)](https://hub.docker.com/r/cm2network/squad/) [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/squad.svg)](https://hub.docker.com/r/cm2network/squad/) [![Docker Stars](https://img.shields.io/docker/stars/cm2network/squad.svg)](https://hub.docker.com/r/cm2network/squad/) [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/squad.svg)](https://hub.docker.com/r/cm2network/squad/) [![](https://images.microbadger.com/badges/image/cm2network/squad.svg)](https://microbadger.com/images/cm2network/squad) [![Discord](https://img.shields.io/discord/747067734029893653)](https://discord.gg/7ntmAwM)
# Supported tags and respective `Dockerfile` links
-	[`latest` (*buster/Dockerfile*)](https://github.com/CM2Walki/Squad/blob/master/buster/Dockerfile)

# What is Squad?
Squad is a tactical FPS that provides authentic combat experiences through teamwork, communication, and gameplay. It seeks to bridge the large gap between arcade shooter and military simulation. Large scale, combined arms combat, base building, and a great integrated VoIP system. <br/>
This Docker image contains the dedicated server of the game. <br/>

> [Squad](http://store.steampowered.com/app/393380/Squad/)

<img src="https://vignette.wikia.nocookie.net/squadgame/images/2/27/Squad_logo.png/revision/latest?cb=20150625185705" alt="logo" width="300"/></img>

# How to use this image

## Hosting a simple game server
Running on the *host* interface (recommended):<br/>
```console
$ docker run -d --net=host -v /home/steam/squad-dedicated/ --name=squad-dedicated cm2network/squad
```

Running using a bind mount for data persistence on container recreation:
```console
$ mkdir -p $(pwd)/squad-data
$ chmod 777 $(pwd)/squad-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host -v $(pwd)/squad-data:/home/steam/squad-dedicated/ --name=squad-dedicated cm2network/squad
```

Running multiple instances (iterate PORT, QUERYPORT and RCONPORT):<br/>
```console
$ docker run -d --net=host -v /home/steam/squad-dedicated/ -e PORT=7788 -e QUERYPORT=27166 -e RCONPORT=21115 --name=squad-dedicated2 cm2network/squad
```

**It's also recommended using "--cpuset-cpus=" to limit the game server to a specific core & thread.**<br/>
**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env):
```dockerfile
PORT=7787
QUERYPORT=27165
RCONPORT=21114
FIXEDMAXPLAYERS=80
FIXEDMAXTICKRATE=50
RANDOM=NONE
```

## Config
The config files can be edited using this command:

```console
$ docker exec -it squad-dedicated nano /home/steam/squad-dedicated/SquadGame/ServerConfig/Server.cfg
```

If you want to learn more about configuring a Squad server check this [documentation](https://squad.gamepedia.com/Server_Configuration).
