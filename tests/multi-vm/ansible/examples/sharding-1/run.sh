#!/usr/bin/env bash

source files/vars.sh

# cleanup
ansible mongo_all -m shell -ba "systemctl stop mongod"
ansible mongo_all -m shell -ba "pkill mongod"

ansible-playbook copy_files.yml

echo "Initiate replicaset"

for i in {0..2}
do
    export SHARD_NAME="sh${i}"
    export CONF_PATH="/data/$SHARD_NAME/init"
    ansible "mongo_${i}" -m shell -a "SHARD_NAME=${SHARD_NAME} && bash ${CONF_PATH}/rs-initiate.sh"
done

SHARD_NAME="cfg"
export CONF_PATH="/data/$SHARD_NAME/init"
ansible "mongo_config" -m shell -a "bash ${CONF_PATH}/rs-initiate.sh"