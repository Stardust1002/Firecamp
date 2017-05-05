all: build

build: build-jupyter build-spark copy-examples

build-spark:
	docker build -t firecamp/spark -f ${PWD}/spark/Dockerfile ${PWD}
	ln ${PWD}/spark/spark-defaults.conf ${PWD}/../../work/project-conf/spark/ || continue

build-jupyter:
	docker build -t firecamp/jupyter -f ${PWD}/jupyter/Dockerfile ${PWD}
	ln ${PWD}/requirements.txt ${PWD}/../../work/project-conf/python/ || continue
	ln ${PWD}/additional_setup.txt ${PWD}/../../work/project-conf/python/ || continue

copy-examples:
	cp -n -R ${PWD}/../Examples ${PWD}/../../work || continue
