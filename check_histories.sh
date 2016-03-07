#!/bin/bash
#
if [ $# -ne 3 ]; then
  echo "USAGE: check_histories.sh GALAXY_HOST APIKEY ID(Galaxy History ID)"
  exit 1
fi
# argv
GALAXY_HOST=$1
APIKEY=$2
HISTORY_ID=$3
#
HISTORIESDETAILFILE=${HISTORY_ID}.txt
rm $HISTORIESDETAILFILE

docker $(docker-machine config jenkinsdockerslave) run --rm manabuishii/galaxy_scripts:0.1.1 galaxy_history_detail.py ${GALAXY_HOST} ${APIKEY} ${HISTORY_ID} --tsv &> ${HISTORIESDETAILFILE}

#
RET=0

if [ ! -e ${HISTORIESDETAILFILE} ]; then
  RET=`expr $RET + 1`
fi
echo "RET=[${RET}] Check FILE [${HISTORIESDETAILFILE}] exists"


if [ ! -s ${HISTORIESDETAILFILE} ]; then
  RET=`expr $RET + 1`
fi
echo "RET=[${RET}] Check FILE [${HISTORIESDETAILFILE}] SIZE"


NONEOKLINE=`cat ${HISTORIESDETAILFILE} | cut -d ',' -f 4 | grep -v state | grep -v ok | wc -l`
if [ ${NONEOKLINE} -ne 0 ]; then
  RET=`expr $RET + 1`
fi
echo "RET=[${RET}] Check result files has some lines except OK"

FILESIZEZERO=`cat ${HISTORIESDETAILFILE} | cut -d ',' -f 5 | grep -v file_size| grep ^0$ | wc -l`
if [ ${FILESIZEZERO} -ne 0 ]; then
  RET=`expr $RET + 1`
fi
echo "RET=[${RET}] Check result value has result filesize is not 0"
echo "TOTAL=${RET}"
exit ${RET}
