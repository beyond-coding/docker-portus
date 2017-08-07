#!/bin/bash

: ${MACHINE_FQDN:?"Set the environment variable MACHINE_FQDN specifying the domain url before running the script. (example: 'export MACHINE_FQDN=www.example.com'"}

HEADER="Docker portus -"

# Checking for consistency

FILE="docker-compose.yml"
if [ -f "$FILE" ]
then
    rm FILE
    echo "$HEADER updating docker-compose file."
else
    echo "$HEADER getting docker-compose file."
fi

# Getting the docker-compose file

wget https://raw.githubusercontent.com/beyond-coding/docker-portus/master/docker-compose-insecure.yml
mv docker-compose-insecure.yml docker-compose.yml

# Getting the registry config file

wget https://raw.githubusercontent.com/beyond-coding/docker-portus/master/config-insecure.yml
mkdir -p ./registry/config
sudo mv config-insecure.yml ./registry/config/config.yml

# Getting the portus certificate

wget https://raw.githubusercontent.com/beyond-coding/docker-portus/master/portus.crt
mkdir -p ./secrets
sudo cp portus.crt ./secrets/.
sudo cp portus.crt /usr/local/share/ca-certificates
sudo update-ca-certificates
rm portus.crt

# Running the services

docker-compose up -d

echo "$HEADER complete."