#!/usr/bin/env bash
# creates a instance in the cloud and runs docker container, uses docker file ai_challenge dir
NM=${1}
SUB="" # copy sub ID here
docker-machine create --driver azure --azure-size Standard_D12 --azure-subscription-id ${SUB} ${NM}
docker-machine env ${NM}
eval $(docker-machine env ${NM})
cd ..
docker build malmo -t malmo:latest
docker build malmopy-cntk-cpu-py27 -t malmopy-cntk-cpu-py27:latest
cd ..
docker build . -t my_exp
cd docker/my_dockerfiles
docker-compose up -d
