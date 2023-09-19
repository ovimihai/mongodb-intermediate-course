#!/usr/bin/env bash

# cleanup
ansible mongo_all -m shell -ba "systemctl stop mongod"
ansible mongo_all -m shell -ba "pkill mongod"

ansible-playbook copy_files.yml

exit

echo "Start mongo instances"
ansible mongo_all -m shell -a "mongod -f /etc/mongod.conf --fork"

echo "Initiate replicaset"
ansible mongo_1 -m shell -a "bash /data/rs0/init/rs-initiate.sh"
