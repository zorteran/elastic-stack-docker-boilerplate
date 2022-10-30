# Secured Elasticsearch + Kibana - Docker Compose

Created for the Elastic Stack Course of mine.
https://wiadrodanych.pl/elastic

## This is the tldr way/script way:
```bash
./bootstrap.sh
```

## This is the manual way:
### 1
```
sudo docker-compose up -d
```
### 2
Create built-in users (save passwords)
```
sudo docker exec elasticsearch /bin/bash -c "bin/elasticsearch-setup-passwords auto --batch --url https://localhost:9200"
```
### 3
Replace kibana password in `docker-compose.yml` and restart containers
```
sudo docker-compose up -d --force-recreate
```
