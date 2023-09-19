#!/bin/bash

sleep 10

mongosh --host mongo1 < /docker-entrypoint-initdb.d/rs-initiate.js

sleep 10

mongosh --host mongo1 test --eval "db.test.insertOne({a:1});" || echo "insert failed"

sleep infinity
