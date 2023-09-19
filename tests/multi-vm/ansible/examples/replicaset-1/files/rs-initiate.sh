#!/bin/bash

echo "waiting for cluster to start "

until [ $(mongosh --quiet --eval "db.adminCommand('ping')" | grep 1 | wc -l) -gt 0 ]; do
    printf "."
    sleep 1
done

mongosh  < /opt/mongo-play/repl-1/rs-initiate.js

sleep 10

mongosh test --eval "db.test.insertOne({a:1});" || echo "insert failed"

