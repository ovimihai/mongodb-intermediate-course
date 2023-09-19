
export REPLICA_NAME=apps

docker-compose -v --remove-orphans down || echo "Not deployed"

printf "waiting to finish"
until [ $(docker network ls | grep "${REPLICA_NAME}_default" | wc -l) -eq 0 ]
do
    printf "."
    sleep 1
done
echo ""


#docker stack deploy --prune -c docker-compose.yml ${REPLICA_NAME}

docker-compose -f docker-compose.yml up -d