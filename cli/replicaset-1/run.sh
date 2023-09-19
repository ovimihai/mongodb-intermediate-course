#!/usr/bin/env bash

source files/vars.sh "$@"

# parse arguments
mongod_extra_arg=""
if [ "$2" == "config" ]; then
    mongod_extra_arg="--configsvr"
fi
if [ "$2" == "shard" ]; then
    mongod_extra_arg="--shardsvr"
fi

echo "Cleaning up"
#sudo systemctl stop mongod
sudo pkill -f "replSet ${RS_NAME}"
sudo rm -fr /data/${RS_NAME}
sudo rm -fr /tmp/mongo-*
sleep 3

echo "Setup replicaset instances"

for i in {0..2}
do
    RS_MEMBER="node-${i}"
    export RS_PATH=/data/${RS_NAME}/${RS_MEMBER}
    RS_CONFIG=mongod-${i}.conf
    export RS_MEMBER_PORT=$((${RS_PORT} + ${i}))

    sudo mkdir -p ${RS_PATH}/db
    sudo chown -R $USER ${RS_PATH}

    envsubst < files/mongod.yaml > ${RS_CONFIG}

    mongod -f ${RS_CONFIG} --replSet ${RS_NAME} ${mongod_extra_arg}
done

echo "waiting for cluster to start "

until [ $(mongosh --port ${RS_PORT} --quiet --eval "db.adminCommand('ping')" | grep 1 | wc -l) -gt 0 ]; do
    printf "."
    sleep 1
done

mongosh --port ${RS_PORT} < files/rs-initiate.js

echo -e "\n"
echo "Connect with: mongosh --port ${RS_PORT}"
echo -e "\n"