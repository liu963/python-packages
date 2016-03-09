#!/bin/bash

# Barebones core installation of a Python environment for use in
# BlueData nodes.

prefix=/opt/python
bin="Miniconda3-latest-Linux-x86_64.sh"
url="https://repo.continuum.io/miniconda/${bin}"
curl -O $url
chmod +x $bin && ./${bin} -f -b -p $prefix && rm ./${bin}
export PATH=${prefix}/bin:$PATH

# Update everything.
conda update -y --all
conda install -y nbformat

# Install all the base packages.
conda install -y decorator gensim h5py hdf5 ipython joblib jupyter matplotlib \
    nltk numpy pandas pillow scipy scikit-learn scikit-image toolz

pip install spark-sklearn
pip install tpot
    