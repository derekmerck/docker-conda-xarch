# xArch Conda Image
# Derek Merck, Summer 2018

ARG RESIN_ARCH="intel-nuc"

FROM resin/${RESIN_ARCH}-debian:stretch
MAINTAINER Derek Merck <derek_merck@brown.edu>

#ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && apt-get install -yq --no-install-recommends \
        wget \
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

ENV TZ=America/New_York
# Disable resin.io's systemd init system
ENV INITSYSTEM off

CMD tail -f /dev/null
