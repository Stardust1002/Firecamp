############################
#### JUPYTER DOCKERFILE ####
############################

FROM jupyter/pyspark-notebook

ENV HOME /home/jovyan/
ENV KERNELS $CONDA_DIR/share/jupyter/kernels/

USER root
RUN apt-get install -y tar unzip gzip

RUN apt-get update && \
    apt-get install -y --no-install-recommends fonts-dejavu && \
    apt-get clean

USER jovyan

RUN pip install --upgrade pip

##### Apache Toree kernel

RUN pip --no-cache-dir install https://dist.apache.org/repos/dist/dev/incubator/toree/0.2.0/snapshots/dev1/toree-pip/toree-0.2.0.dev1.tar.gz

RUN jupyter toree install  --sys-prefix --spark_home=$SPARK_HOME

##### INSTALLING ADDITIONAL DEPEDENCIES

RUN    pip install pigar && \
       mkdir /tmp/project-conf

COPY requirements.txt /tmp/project-conf/

COPY additional_setup.txt /tmp/project-conf/

RUN pip install -r /tmp/project-conf/requirements.txt && \
    sh /tmp/project-conf/additional_setup.txt

##### CLEANING UP

RUN rm -rf /tmp/project-conf

WORKDIR $HOME/work
