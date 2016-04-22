#!/bin/bash

if [ $# -ne 3 ]; then
  echo "USAGE: check_histories.sh GALAXY_HOST APIKEY ID(Galaxy History ID)"
  exit 1
fi
# argv
GALAXY_HOST=$1
APIKEY=$2
HISTORY_ID=$3

#docker $(docker-machine config jenkinsdockerslave) run --rm manabuishii/galaxy_scripts:0.2.0 galaxy_history_detail.py ${GALAXY_HOST} ${APIKEY} ${HISTORY_ID} --tsv | tail -n +2 |  cut --delimiter=, -f4 | sort | uniq
#
while true
do
  echo "Get ${HISTORY_ID} status"
  STATES=$(docker $(docker-machine config jenkinsdockerslave) run --rm manabuishii/galaxy_scripts:0.2.0 galaxy_history_detail.py ${GALAXY_HOST} ${APIKEY} ${HISTORY_ID} --tsv | tail -n +2 |  cut --delimiter=, -f4 | sort | uniq)
  ERRORFLAG=0
  RUNNINGFLAG=0
  OKFLAG=0
  QUEUEDFLAG=0
  for STATE in ${STATES}
  do
    if [ ${STATE} == "ok" ];
    then
      OKFLAG=1
    elif [ ${STATE} == "error" ];
    then
      ERRORFLAG=1
    elif [ ${STATE} == "running" ];
    then
      RUNNINGFLAG=1
    elif [ ${STATE} == "queued" ];
    then
      QUEUEDFLAG=1
    fi
  done
  #
  if [ ${ERRORFLAG} -eq 1 ];
  then
    echo "There is error"
    exit 1
  fi
  if [ ${OKFLAG} -eq 1 ];
  then
    if [ ${RUNNINGFLAG} -eq 0 -a ${QUEUEDFLAG} -eq 0 ];
    then
      echo "All job are ok"
      break
    fi
  fi
  if [ ${RUNNINGFLAG} -eq 1 -o ${QUEUEDFLAG} -eq 1 ];
  then
    echo "There are running jobs or queued jobs."
  fi

  echo "Sleep 1min"
  sleep 60
done
