#!/bin/bash

cp -rf ../../src/gr-rircsim .
touch /tmp/blue1.psd-log
touch /tmp/blue2.psd-log
touch /tmp/red1.psd-log
touch /tmp/.X11-unix\
UID=1000
target_uid=UID docker compose build
rm -rf gr-rircsim
