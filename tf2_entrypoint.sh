#!/bin/bash
set -e
trap '' TERM INT HUP
./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 232250 validate +quit

cd tf2
./srcds_run -game tf -console +sv_pure 1 +randommap +maxplayers 24
