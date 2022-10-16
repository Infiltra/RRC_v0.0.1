#!/bin/bash

docker-compose exec marshal bash -c 'python3 /grc/scoring/main.py -S 0.0.0.0 -s blue2'
