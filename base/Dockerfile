FROM phusion/baseimage:0.9.15
MAINTAINER Mark Borcherding <MarkBorcherding@gmail.com>

# Install all the nice to haves
RUN apt-get update && \
    apt-get --quiet --yes install \
            curl \
            git \
            htop \
            tmux \
            vim \
            wget \
            && \
    apt-get clean

