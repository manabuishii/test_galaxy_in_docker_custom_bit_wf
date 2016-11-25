#!/bin/bash



if [ "x$EXEC_UID" == "x" ]
    then
        EXEC_UID=`id -u`
fi
if [ "x$EXEC_USERNAME" == "x" ]
    then
        EXEC_USERNAME=`whoami`
fi
if [ "x$EXEC_GALAXY_USER" == "x" ]
    then
        EXEC_GALAXY_USER='galaxy'
fi
#if [ "x$SGEMASTERHOST" == "x" ]
#    then
#        SGEMASTERHOST=`hostname`
#fi
if [ "x$CONTAINER_NAME" == "x" ]
    then
        CONTAINER_NAME='galaxytestcontainer'
fi



if [ "x$DOCKERIMAGE" == "x" ]
    then
        DOCKERIMAGE=myoshimura080822/galaxy_in_docker_bitwf:160607
fi
echo "Using Docker image [${DOCKERIMAGE}]"
echo "Exec user UID [${EXEC_UID}]"
echo "Exec username [${EXEC_USERNAME}]"
echo "DEFAULT GALAXY USERNAME [${EXEC_GALAXY_USER}]"
echo "Data directory [${DATADIR}]"

for ARG in "$@"
do
  if [ "${ARG}" == "--dry-run" ]
  then
    echo "DRYRUN"
    exit
  fi
done
exit

docker run --privileged=true --net=host --rm \
 -e GALAXY_CONFIG_FILE_PATH=$PWD/export/files \
 -e GALAXY_CONFIG_JOB_WORKING_DIRECTORY=$PWD/export/job_working_directory \
 -e SGE_ROOT=/var/lib/gridengine \
 -e "NONUSE=nodejs,reports,proftpd,condor" \
 -e GALAXY_UID=${EXEC_UID} \
 -v $PWD:$PWD \
 -v ${EXPORTDIR}:/export \
 -v ${DATADIR}:/data \
 -v $PWD/setup_inside_container.sh:/galaxy-central/setup_inside_container.sh \
 -ti --name=${CONTAINER_NAME}  \
 ${DOCKERIMAGE} \
 /bin/bash
