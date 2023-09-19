#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0 ))

source ${CURRENT_DIR}/vars.sh

cd ${CONF_PATH}

echo "Start mongo instances"

config_file="mongod.yaml"
if [ "$SHARD_NAME" = "cfg" ]; then
    config_file="mongod-config.yaml"
fi


for i in {0..2}
do
    export RS_NAME="${RS_NAME_PREFIX}${i}"
    export RS_PORT=$((${RS_BASE_PORT}+$i))
    export RS_SH_NAME="${SHARD_NAME}_${RS_NAME}"
    dest="mongod-${i}.yaml"

    echo "Generate config for ${RS_SH_NAME}"
    envsubst < $config_file > ${dest}

    echo "Start instance ${RS_SH_NAME}"
    mongod -f ${dest} --fork
done

echo "waiting for cluster to start "

until [ $(mongosh --port ${RS_BASE_PORT} --quiet --eval "db.adminCommand('ping')" | grep 1 | wc -l) -gt 0 ]; do
    printf "."
    sleep 1
done

export HOST=$(hostname)
mongosh --port ${RS_BASE_PORT} < "${CONF_PATH}/rs-initiate.js"

sleep 10

if [ "$SHARD_NAME" = "cfg" ]; then
    print "Config Server setup"
else
    mongosh test --port ${RS_BASE_PORT} --eval "db.test.insertOne({a:1});" || echo "insert failed"
fi