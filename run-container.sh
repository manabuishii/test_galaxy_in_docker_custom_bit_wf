#!/bin/bash
#

DOCKERHOST=$1
SCRIPT=$2
GALAXYHOST=$3

docker-machine ssh ${DOCKERHOST} "sudo mkdir -p $PWD; sudo chmod 777 $PWD"
docker-machine scp -r . ${DOCKERHOST}:$PWD
docker $(docker-machine config ${DOCKERHOST} ) run --rm -v $PWD:/work ebeltran/webdriver-ruby ruby /work/${SCRPT}
docker-machine scp -r ${DOCKERHOST}:$PWD/*.png .
