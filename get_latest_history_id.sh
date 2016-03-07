#!/bin/bash

if [ $# -ne 2 ]; then
  echo "USAGE: get_latest_history_id.sh GALAXY_HOST APIKEY"
  exit 1
fi
# argv
GALAXY_HOST=$1
APIKEY=$2
JENKINSJOBURL=$3

#
docker $(docker-machine config jenkinsdockerslave) run --rm manabuishii/galaxy_scripts:0.2.0 galaxy_histories.py ${GALAXY_HOST} ${APIKEY} | jq -r '.[0].id'
