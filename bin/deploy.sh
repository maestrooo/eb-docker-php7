#!/bin/bash

. .env

aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.us-west-2.amazonaws.com"
docker tag php7:latest "${AWS_ACCOUNT_ID}.dkr.ecr.us-west-2.amazonaws.com/php7:latest"
docker push "${AWS_ACCOUNT_ID}.dkr.ecr.us-west-2.amazonaws.com/php7:latest"
