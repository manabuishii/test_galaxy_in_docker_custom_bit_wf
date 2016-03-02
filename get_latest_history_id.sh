#!/bin/bash

if [ $# -ne 2 ]; then
  echo "USAGE: check_histories.txt GALAXY_HOST APIKEY"
  exit 1
fi
# argv
GALAXY_HOST=$1
APIKEY=$2
JENKINSJOBURL=$3

#
docker $(docker-machine config jenkinsdockerslave) run --rm manabuishii/galaxy_scripts:0.1.1 galaxy_histories.py ${GALAXY_HOST} ${APIKEY} | jq -r '.[0].id'
