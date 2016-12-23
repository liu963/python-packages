#!/bin/bash

# Barebones core installation of a Python environment for use in a dask cluster.

prefix=/opt/python
bin="Miniconda3-latest-Linux-x86_64.sh"
url="https://repo.continuum.io/miniconda/${bin}"
wget $url
chmod +x $bin && ./${bin} -f -b -p $prefix && rm ./${bin}
export PATH=${prefix}/bin:$PATH

# Update everything.
conda update -y --all
conda install -y nbformat

# Install all the base packages.
conda install -y bokeh dask decorator gensim h5py hdf5 ipython joblib jupyter \
    matplotlib nltk numpy pandas pillow psutil scipy scikit-learn scikit-image \
    toolz terminado
conda install -y distributed -c conda-forge    
