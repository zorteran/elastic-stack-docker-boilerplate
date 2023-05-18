#!/bin/bash

# Check if Docker command can be executed
if ! docker compose up -d elasticsearch; then
    echo "Looks like you don't have permission to use Docker."
    exit 1
fi

# Wait for Elasticsearch to be available with a timeout
timeout=60
elapsed=0

until curl --insecure --silent --output /dev/null https://localhost:9200; do
    echo "Waiting for Elasticsearch to start..."
    sleep 5
    ((elapsed+=5))

    if ((elapsed >= timeout)); then
        echo "Timed out waiting for Elasticsearch to start."
        exit 1
    fi
done

docker exec elasticsearch /bin/bash -c "bin/elasticsearch-setup-passwords auto --batch --url https://localhost:9200" >> creds.txt
NEW_PASS=$(grep "PASSWORD kibana_system" creds.txt | awk '{print substr($0, length($0)-19, length($0))}')
sed -i "s/CHANGE_ME_PLS/$NEW_PASS/" docker-compose.yml
docker compose up -d kibana
