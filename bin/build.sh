#!/bin/bash

. .env

docker build --no-cache -t php7 .
