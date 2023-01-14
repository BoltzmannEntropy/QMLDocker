#!/usr/bin/env bash
docker run  --platform linux/amd64 -it --env="DISPLAY" -p 8097:7842 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -e DISPLAY -e XAUTHORITY -v /Users/sol/dev/:/home/qmuser/sharedfolder  quantdoc:latest bash
