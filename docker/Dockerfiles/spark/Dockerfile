
##########################
#### SPARK DOCKERFILE ####
##########################

FROM java:8

USER root

WORKDIR /tmp

RUN apt-get install -y tar unzip gzip

ENV APACHE_SPARK_VERSION 2.1.0
ENV APACHE_HADOOP_VERSION 2.7
ENV SHELL /bin/bash
ENV PYTHONHASHSEED 0
ENV CONDA_VERSION 4.3.11
ENV CONDA_HOME /opt/conda

RUN apt-get update && apt-get install -y wget

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda config --prepend channels https://conda.anaconda.org/conda-forge

RUN     wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${APACHE_HADOOP_VERSION}.tgz && \
        tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${APACHE_HADOOP_VERSION}.tgz -C /usr/local && \
        rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${APACHE_HADOOP_VERSION}.tgz

RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${APACHE_HADOOP_VERSION} spark

##### INSTALLING ADDITIONAL DEPENDENCIES

RUN pip install --upgrade pip

COPY requirements.txt .

COPY additional_setup.txt .

RUN pip install -r ./requirements.txt && sh ./additional_setup.txt

##### CLEANING EVERYTHING UP

RUN rm -rf /tmp/*
