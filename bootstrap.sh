#!/bin/bash
docker compose up -d elasticsearch
sleep 60 # TODO: make it more elegant
docker exec elasticsearch /bin/bash -c "bin/elasticsearch-setup-passwords auto --batch --url https://localhost:9200" >> creds.txt
NEW_PASS=$(cat creds.txt | grep "PASSWORD kibana_system" | awk '{print substr($0,length($0)-19,length($0))}')
sed -i "s/CHANGE_ME_PLS/$NEW_PASS/" docker-compose.yml
docker compose up -d kibana
