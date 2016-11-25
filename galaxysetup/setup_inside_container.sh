#!/bin/bash

## your UID and USERNAME
#EXEC_UID=$1
#EXEC_USERNAME=$2
## galaxy is default
#EXEC_GALAXY_USER=$3
## if you have SGE env
#SGEMASTERHOST=$4

usermod --uid ${EXEC_UID} --login ${EXEC_USERNAME} ${EXEC_GALAXY_USER}
chown -R ${EXEC_USERNAME} /galaxy-central /shed_tools
apt-get -qq update && apt-get install --no-install-recommends -y gridengine-common gridengine-drmaa1.0
echo "${SGEMASTERHOST}" > /var/lib/gridengine/default/common/act_qmaster
sed -i -e '1c\user  ${EXEC_USERNAME} ${EXEC_GALAXY_USER};' /etc/nginx/nginx.conf
sed -i -e 's/= ${EXEC_GALAXY_USER}/= ${EXEC_USERNAME}/g' /etc/supervisor/conf.d/galaxy.conf
# skip copy .distribution_config dir
sed -i -e "s/shutil.copytree( '\/galaxy-central\/config\/', '\/export\/.distribution_config\/' )/shutil.copytree( '\/galaxy-central\/config\/', '\/export\/.distribution_config\/' ,true)/" /usr/local/bin/export_user_files.py

