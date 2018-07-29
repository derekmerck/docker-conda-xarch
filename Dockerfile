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

RUN wget --quiet "$CONDA_PKG" -O ~/conda.sh \
    && yes | /bin/bash ~/conda.sh -b -f -p /opt/conda \
    && rm ~/conda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && conda create -n base --clone root || echo "Error: Could not create base (already exists in Miniconda?)" \
    && echo "source activate base" >> ~/.bashrc

# In a new shell
# Conda is _missing_ from JetsonConda!
RUN conda update -y conda || echo "Error: Failed to update conda (check path?)"
RUN pip install --upgrade pip

ENV TZ=America/New_York
# Disable resin.io's systemd init system
ENV INITSYSTEM off

CMD tail -f /dev/null
