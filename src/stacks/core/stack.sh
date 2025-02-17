#!/usr/bin/env bash

source init

if [[ -z "$SCRIPT_DIR" ]]; then
    export SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
fi

[[ ! -d "/mnt/vol/docker/traefik/cert" ]] && mkdir -p /mnt/vol/docker/traefik/cert
[[ ! -d "/mnt/vol/docker/traefik/conf" ]] && mkdir -p /mnt/vol/docker/traefik/conf
[[ ! -d "/mnt/vol/docker/traefik/logs" ]] && mkdir -p /mnt/vol/docker/traefik/logs

DATADIR="$(dirname $(dirname "$SCRIPT_DIR") )/data/traefik/volumes"

cp ../../data/traefik/volumes/cert/* /mnt/vol/docker/traefik/cert/.
cp ../../data/traefik/volumes/conf/* /mnt/vol/docker/traefik/conf/.
cp ../../data/traefik/volumes/logs/* /mnt/vol/docker/traefik/logs/.



docker stack deploy -c traefik.yml traefik
