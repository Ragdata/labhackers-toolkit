#!/usr/bin/env bash

source init

if [[ -z "$SCRIPT_DIR" ]]; then
    export SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
fi

[[ ! -d "$DOCKER_VOL/traefik/cert" ]] && mkdir -p "$DOCKER_VOL/traefik/cert"
[[ ! -d "$DOCKER_VOL/traefik/conf" ]] && mkdir -p "$DOCKER_VOL/traefik/conf"
[[ ! -d "$DOCKER_VOL/traefik/logs" ]] && mkdir -p "$DOCKER_VOL/traefik/logs"

DATADIR="$(dirname $(dirname "$SCRIPT_DIR") )/data/traefik/volumes"

cp "$DATADIR"/cert/* "$DOCKER_VOL"/traefik/cert/.
cp "$DATADIR"/conf/* "$DOCKER_VOL"/traefik/conf/.
cp "$DATADIR"/logs/* "$DOCKER_VOL"/traefik/logs/.



docker stack deploy -c core-compose.yml
