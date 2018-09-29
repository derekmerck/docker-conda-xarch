# xArch Conda Image
# Derek Merck, Summer 2018

ARG DOCKER_ARCH="amd64"
# ARG DOCKER_ARCH="arm32v7"
# ARG DOCKER_ARCH="arm64v8"

LABEL maintainer="Derek Merck"
LABEL email="derek_merck@brown.edu"
LABEL description="X-Arch Conda"
LABEL vendor="Rhode Island Hospital"
LABEL architecture="$DOCKER_ARCH"
LABEL os="linux"

FROM resin/${RESIN_ARCH}-debian:stretch
MAINTAINER Derek Merck <derek_merck@brown.edu>

#ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt -y clean && apt -y update && apt -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends \
    curl \
    bzip2 \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

ARG CONDA_PKG=https://repo.continuum.io/miniconda/Miniconda2-4.4.10-Linux-x86_64.sh

# Doesn't exist on BerryConda
COPY conda.sh /opt/conda/etc/profile.d/conda.sh

RUN curl -L -o /tmp/conda.sh "$CONDA_PKG" \
    && yes | /bin/bash /tmp/conda.sh -b -f -p /opt/conda \
    && rm /tmp/conda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

RUN conda config --append channels jetson-tx2 \
    && conda config --append channels aarch64_gbox \
    && conda update -y conda || echo "Error: Failed to update conda (check path?)" \
    && pip install --upgrade pip \
    && conda create -n base --clone root || echo "Error: Could not create base (already exists in Miniconda?)" \
    && echo "source activate base" >> ~/.bashrc \
    && pip install --upgrade pip

# Leave entrypoint alone for resin-init
CMD ["tail", "-f", "/dev/null"]

ENV TZ=America/New_York
# Disable resin.io's systemd init system
ENV INITSYSTEM off
