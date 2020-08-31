FROM jupyter/base-notebook:python-3.8.5

USER root

RUN echo "jovyan:redspot" | chpasswd

USER ${NB_USER}
