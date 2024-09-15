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
  "cas-config.yaml"
  "cas-deployment.yaml"
  "cas-secret.yaml"
  "cas-service.yaml"
  "network-policy.yaml"
  "pgdata-pvc.yaml"
  "postgres-deployment.yaml"
  "postgres-service.yaml"
)

for file in "${YAML_FILES[@]}"; do
  file="$K8S_FOLDER/$file"
  echo "${command^}ing $file ..."
  envsubst < $file | kubectl "$command" -f -
done
