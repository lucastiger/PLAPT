FROM pytorch/pytorch:2.3.1-cuda11.8-cudnn8-runtime

LABEL authors="Colby T. Ford <colby@tuple.xyz>"

## Install system requirements
RUN apt update && \
    apt-get install -y --reinstall \
        ca-certificates && \
    apt install -y \
        git \
        wget \
        gcc \
        g++

## Set working directory
RUN mkdir -p /software/plapt
WORKDIR /software/plapt

## Clone project
RUN git clone https://github.com/Bindwell/PLAPT /software/plapt

## Create Conda Environment
RUN conda env create -f /software/plapt/environment.yml

## Automatically activate conda environment
RUN echo "source activate plapt" >> /etc/profile.d/conda.sh && \
    echo "source /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate plapt" >> ~/.bashrc