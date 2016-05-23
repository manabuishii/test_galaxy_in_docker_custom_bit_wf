#!/bin/bash
#

if [ $# -lt 2 ]; then
  echo "Usage SCRIPT GALAXYHOST [other options pass to test script]"
  exit 1
fi
#
SCRIPT=$1
GALAXYHOST=$2
# remove 3 params
shift 2

#
docker run --net=host --rm -v $PWD:/work ebeltran/webdriver-ruby ruby /work/${SCRIPT} ${GALAXYHOST} "$@"
RET=$?
# TODO: timestamp to file
#
echo "RET=[$RET] if RET is not 0, maybe your Galaxy environment do not set data library"
exit ${RET}
