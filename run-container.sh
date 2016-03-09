#!/bin/bash
#

if [ $# -lt 3 ]; then
  echo "Usage DOCKERHOST SCRIPT GALAXYHOST [other options pass to test script]"
  exit 1
fi
#
DOCKERHOST=$1
SCRIPT=$2
GALAXYHOST=$3
# remove 3 params
shift 3

mkdir -p images
# TODO change rm -rf to something
docker-machine ssh ${DOCKERHOST} "sudo rm -rf $PWD ; sudo mkdir -p $PWD; sudo chmod 777 $PWD"
for RUBYFILE in $(ls *.rb)
do
  docker-machine scp ${RUBYFILE} ${DOCKERHOST}:$PWD
done
docker $(docker-machine config ${DOCKERHOST} ) run --rm -v $PWD:/work ebeltran/webdriver-ruby ruby /work/${SCRIPT} ${GALAXYHOST} "$@"
RET=$?
# TODO timestamp to file
docker-machine scp -r ${DOCKERHOST}:$PWD/*.png images/
echo "RET=[$RET] if RET is not 0, maybe your Galaxy environment do not set data library"
exit ${RET}
