#!/bin/bash

if [ $# -ne 3 ]; then
  echo "USAGE: get_history_name_by_id.sh GALAXY_HOST APIKEY HISTORY_ID"
  exit 1
fi
# argv
GALAXY_HOST=$1
APIKEY=$2
HISTORY_ID=$3

#
docker $(docker-machine config jenkinsdockerslave) run --rm manabuishii/galaxy_scripts:0.2.0 galaxy_histories.py ${GALAXY_HOST} ${APIKEY} ${HISTORY_ID}| jq -r '.[0].name'
