#!/bin/bash

if [ "$TRAVIS_PULL_REQUEST" = "true" ] || [ "$TRAVIS_BRANCH" != "master" ]; then
  docker buildx build --progress plain --platform=linux/arm/v7 .
  exit $?
fi
echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin &> /dev/null
TAG="${TRAVIS_TAG:-latest}"
docker buildx build --progress plain --platform=linux/arm/v7 -t $DOCKER_REPO:$TAG --push .
