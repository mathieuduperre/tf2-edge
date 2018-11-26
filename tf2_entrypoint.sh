#!/bin/bash
set -e
trap '' TERM INT HUP

cd tf2
./srcds_run -game tf -console +sv_pure 1 +randommap +maxplayers 24
