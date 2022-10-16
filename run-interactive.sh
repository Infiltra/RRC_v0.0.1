#!/bin/bash

./build.sh

UID=1000
target_uid=UID docker compose -f docker-compose.yml -f docker-compose.headless.yml up