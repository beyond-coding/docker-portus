#!/bin/bash

: ${MACHINE_FQDN:?"Set the environment variable GITLAB_HOST before running the script. (example: 'export MACHINE_FQDN=www.example.com'"}

HEADER="Docker portus -"

# Getting the docker-compose file

FILE="docker-compose.yml"
if [ -f "$FILE" ]
then
    rm FILE
    echo "$HEADER updating docker-compose file."
else
    echo "$HEADER getting docker-compose file."
fi

wget https://raw.githubusercontent.com/beyond-coding/docker-portus/master/docker-compose-insecure.yml
mv docker-compose-insecure.yml docker-compose.yml

# Running the services

docker-compose up -d

echo "$HEADER complete."