#!/bin/sh
set -e -x

# Platform: Mac OS
# 1. Docker Desktop -> Settings -> Resources -> File sharing, then Add path /opt/datadog-agent/run
# 2. Run the following command
# ref: https://docs.datadoghq.com/ja/containers/docker/log/?tab=fromfile

DD_API_KEY="<DD_API_KEY>"
DD_SITE="datadoghq.com"
docker run -d --name datadog-agent \
           --cgroupns host \
           --pid host \
           -e DD_API_KEY=${DD_API_KEY} \
           -e DD_LOGS_ENABLED=true \
           -e DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true \
           -e DD_LOGS_CONFIG_DOCKER_CONTAINER_USE_FILE=true \
           -e DD_CONTAINER_EXCLUDE="name:datadog-agent" \
           -e DD_SITE=${DD_SITE} \
           -v /var/run/docker.sock:/var/run/docker.sock:ro \
           -v /var/lib/docker/containers:/var/lib/docker/containers:ro \
           -v /opt/datadog-agent/run:/opt/datadog-agent/run:rw \
           gcr.io/datadoghq/agent:latest
