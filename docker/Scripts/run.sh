#!/bin/sh
sudo chmod a+rw -R $PWD/work
sh $PWD/docker/Scripts/save.sh previous_run
docker-compose -f $PWD/docker/docker-compose.yml -p firecamp up
sudo chmod a+rw -R $PWD/work
