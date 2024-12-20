#!/bin/bash

usage() {
  echo "Usage: $0 (apply|delete)"
}

if [ $# -ne 1 ]; then
  usage
  exit 1
fi

command=$1

if [ "$1" != "apply" ] && [ "$1" != "delete" ]; then
  usage
  exit 1
fi

K8S_FOLDER="./yaml"

YAML_FILES=(
  "configs/cas.yaml"
  "deployments/cas.yaml"
  "secrets/cas.yaml"
  "services/cas.yaml"
  "policies/network.yaml"
  "pvcs/pgdata.yaml"
  "deployments/postgres.yaml"
  "services/postgres.yaml"
  "networking/ingress.yaml"
  "networking/balance.yaml"
)

for file in "${YAML_FILES[@]}"; do
  file="$K8S_FOLDER/$file"
  echo "${command^}ing $file ..."
  envsubst < $file | kubectl "$command" -f -
done
