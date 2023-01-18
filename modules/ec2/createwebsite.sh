#! /bin/bash

set -e

IMAGE_TAG="$GITHUB_SHA"
IMAGE_ARN=$1

aws ecr get-login-password --region < AWS-REGION > | docker login --username AWS --password-stdin < YOUR-ECR-URI >

docker build -t < DOCKER-IMAGE-NAME >:$IMAGE_TAG .

docker tag < DOCKER-IMAGE-NAME >:$IMAGE_TAG $IMAGE_ARN:$IMAGE_TAG

docker push $IMAGE_ARN:$IMAGE_TAG
