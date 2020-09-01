FROM jupyter/base-notebook:python-3.8.5

USER root

WORKDIR ./home/jovyan

RUN sh ./start.sh

RUN export NODEJS_VER=v10.2
RUN export TELEBIT_VERSION=master
RUN export TELEBIT_USERSPACE=no
RUN export TELEBIT_PATH=/opt/telebit
RUN export TELEBIT_USER=telebit
RUN export TELEBIT_GROUP=telebit

RUN curl https://get.telebit.io/ | bash


USER ${NB_USER}
