#!/bin/bash
if [ -z "$1" ]; then
    read -p "type the name of your project: " input
    PROJECT_NAME=$input
else
    PROJECT_NAME=$1
fi
docker run \
  --name creator \
  --volume ./app:/workspace \
  --workdir /workspace \
  python:3.11-slim bash -c \
  'pip install poetry && poetry new '"$PROJECT_NAME"' && cd $_ && poetry install'
docker rm creator
sed -i '' "s/sample_project/$PROJECT_NAME/g" Dockerfile