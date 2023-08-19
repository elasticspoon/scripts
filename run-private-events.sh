#!/usr/bin/env bash

docker pull oozy5437/private_events:prod
docker run -d -p 80:3000 --env-file ~/docker.env --name web oozy5437/private_events:prod
