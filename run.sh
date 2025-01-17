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

YAML_FILES=( "postgres.yaml" "backend.yaml" "frontend.yaml" )

for file in "${YAML_FILES[@]}"; do
  file="$K8S_FOLDER/$file"
  echo "${command^}ing $file ..."
  envsubst < $file | kubectl "$command" -f -
done
