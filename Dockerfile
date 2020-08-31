FROM jupyter/base-notebook:python-3.8.5

USER root
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
   
RUN echo "jovyan:redspot" | chpasswd

USER ${NB_USER}
