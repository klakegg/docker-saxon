#!/bin/sh

docker build -f Dockerfile -t saxon:base .
docker build -f Dockerfile-he -t saxon:he .
docker build -f Dockerfile-graal -t saxon:graal .
