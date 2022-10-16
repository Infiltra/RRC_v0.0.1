#!/bin/bash

./build.sh

# spin up the containers
target_uid=$UID team_name=$1 docker-compose -f docker-compose.yml -f docker-compose.headless.yml up &
sleep 5

# wait for containers to have READY status
function wait_for_ready {
    while true; do
        status=$(docker-compose exec $1 /scripts/$1-status.sh)
        if [[ "$status" = READY* ]]; then
            echo "$1 is ready"
            break
        fi
        sleep 1
        echo "waiting for $1 to become ready"
    done
}
wait_for_ready blue1
wait_for_ready blue2
wait_for_ready red1
wait_for_ready muxer
wait_for_ready marshal

# kick off the marshal
echo "containers are online; kicking off the match"
docker-compose exec marshal bash -c "touch /tmp/start.txt"

# wait for marshal
while true; do
    res=$(docker-compose ps | grep marshal | grep -o 'Exit 0')
    if [ "$res" = "Exit 0" ]; then
        echo "marshal has exited, shutting down the other containers"
        docker-compose stop
        sleep 1
        break
    fi
    sleep 0.1
done

# read the score
score=$(cat ../../src/scoring/score.txt)
echo "Score: $score"
