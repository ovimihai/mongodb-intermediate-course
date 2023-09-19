#!/usr/bin/env bash

export RS_NO=${1:-1}
export RS_NAME="rs${RS_NO}"
echo "ReplicaSet: $RS_NAME"
export RS_PORT=$((27000 + (10 * $RS_NO)))
