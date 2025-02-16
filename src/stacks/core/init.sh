#!/usr/bin/env bash

export SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source "$(dirname $(dirname "$SCRIPT_DIR") )/lib/functions.sh"

file2env "$(dirname $(dirname "$SCRIPT_DIR") )/common.env"

export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
export HASHED_PASSWORD=$(openssl passwd -apr1)

export INGRESS_SUBNET="$(docker network inspect ingress | jq '.[].IPAM.Config[0].Subnet')"
export INGRESS_GATEWAY="$(docker network inspect ingress | jq '.[].IPAM.Config[0].Gateway')"

docker node update --label-add traefik-certs=true $NODE_ID

docker network rm ingress
docker network create --ingress --driver=overlay --opt=encrypted --scope=swarm --subnet="${INGRESS_SUBNET}" --gateway="${INGRESS_GATEWAY}" ingress

