#!/bin/bash

IMAGES=("academic-subscription-service" "user-service" "mail-service" "auth-service" "eureka-service" "schedule-consumer-service" "api-gateway" "statistics-service")

for IMAGE in "${IMAGES[@]}"; do
  docker tag $IMAGE:latest juanmiacosta/$IMAGE:latest
  docker push juanmiacosta/$IMAGE:latest
done