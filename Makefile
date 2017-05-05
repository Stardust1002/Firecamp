all: setup build run

run:
	sudo sh ${PWD}/docker/Scripts/run.sh

backup:
	sh ${PWD}/docker/Scripts/save.sh

setup:
	sh ${PWD}/docker/Scripts/setup.sh

build:
	cd ${PWD}/docker/Dockerfiles && $(MAKE)
