# xArch Conda Builder/Constructor Image
# Derek Merck, Summer 2018

FROM derekmerck/conda:py3-amd64
MAINTAINER Derek Merck <derek_merck@brown.edu>

RUN apt-get update && apt-get install -yq --no-install-recommends \
        git \
        bzip2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN conda install libconda

#RUN pip install git+git://github.com/ericdill/constructor.git@blacklist-noarch-python
#RUN sed -i "s#create(info, verbose=verbose)#create(info)#" /opt/conda/lib/python3.6/site-packages/constructor/main.py
#RUN wget -o /opt/conda/lib/python3.6/site-packages/constructor/header.sh https://raw.githubusercontent.com/ericdill/constructor/blacklist-noarch-python/constructor/header.sh

RUN conda install constructor
COPY construct.yaml /opt/build/construct.yaml
RUN constructor --platform=linux-aarch64 /opt/build

# COPY /opt/jetsonconda/JetsonConda-0.2.1-Linux-aarch64.sh .

#
## pillow
## keras
## tensorflow from wheels?
#
#RUN conda install -y numpy scipy h5py pyyaml pillow
#RUN pip install parameterized pydicom ruamel.yaml pydot grpcio protobuf tensorboard \
#    astor gast absl-py termcolor
#
#
#
#
#
#RUN conda install conda-build
#
## Upgrade conda-build from 3.3 to 3.12
#RUN pip install psutil pytest-cov
#RUN cd /usr/share/source \
#    && git clone https://github.com/conda/conda-build.git
## TODO: remove lines in meta about git, pytest-cov
#RUN cd /usr/share/source/conda-build/conda.recipe \
#    && conda-build . --python=3.4
## TODO: Upload to Anaconda channel
#
## Create a Python 3.4 env?  Will I need to recompile numpy etc?
#
#
#
## Cannot build tf for py36 - uses existing wheels
#RUN cd /usr/share/source \
#    && git clone https://github.com/conda-forge/tensorflow-feedstock.git
#RUN cd /usr/share/source/tensorflow-feedstock/recipe \
#    && conda-build .
#
## Build for py36
#RUN cd /usr/share/source \
#    && git clone https://github.com/conda-forge/keras-feedstock.git
#RUN cd /usr/share/source/keras-feedstock/recipe \
#    && conda-build .
#
#
#
#
#RUN git https://github.com/ContinuumIO/anaconda-recipes.git
#RUN cd anaconda-recipes/python-3.4 \
#    && conda-build . --python3.4
#
#    https://github.com/conda-forge/tensorflow-feedstock.git
#
#RUN conda create py34 python=3.4
#
#RUN apt update  \
#    && apt install -y --no-install-recommends \
#         libopenblas-base \
#         libhdf5-dev \
#         libatlas-base-dev \
#         libatlas-dev
#
#
#
#
#RUN mkdir /usr/share/source
#
#
## Cannot build tf for py36 - uses existing wheels
#RUN cd /usr/share/source \
#    && git clone https://github.com/conda-forge/tensorflow-feedstock.git
#RUN cd /usr/share/source/tensorflow-feedstock/recipe \
#    && conda-build .
