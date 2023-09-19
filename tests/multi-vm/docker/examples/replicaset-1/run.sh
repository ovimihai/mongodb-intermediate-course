
export REPLICA_NAME=mongorpl-1

docker stack rm ${REPLICA_NAME}

printf "waiting to finish"
until [ $(docker network ls | grep "${REPLICA_NAME}_default" | wc -l) -eq 0 ]; do
    printf "."
    sleep 1
done
echo ""


docker stack deploy --prune -c docker-compose.yml ${REPLICA_NAME}