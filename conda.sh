#!/bin/bash

# Anaconda environment setup script. By default, it installs a linux Miniconda
# for Python 3 and creates a parallel Python 2 environment.

#############################
### CONFIGURATION OPTIONS ###
#############################

os="linux"  # You can change this to "osx" if you're on a Mac.
py2=true  # You can change this to false if you don't want a Py2 environment.
prefix=/opt/python

##############################
### THAT'T IT, YOU'RE DONE ###
##############################

# Now let the installer do its thing.

# First step: download Miniconda.
f="Linux"
if [[ "$os" == "osx" ]]; then
    f="MacOSX"
fi
bin="Miniconda3-latest-${f}-x86_64.sh"
url="https://repo.continuum.io/miniconda/${bin}"
curl -O $url
chmod +x $bin && ./${bin} -f -b -p $prefix && rm ./${bin}
export PATH=${prefix}/bin:$PATH

# Update everything.
conda update -y --all
conda install -y nbformat

# Add the condarc file.
cp environment.yml ${prefix}/
conda env update -n root -f ${prefix}/environment.yml
if [[ "$py2" == true ]]; then
    conda create -y -n python2 python=2
    conda env update -n python2 -f ${prefix}/environment.yml
    source activate python2

    #################################
    ### INSTALL PYTHON 2 PACKAGES ###
    #################################

    if [[ "$os" == "linux" ]]; then
        conda install -y starcluster theano
    fi

    conda install -y astropy beautiful-soup future protobuf pyamg
    pip install thunder-python

    ##############################
    ### THAT'T IT, YOU'RE DONE ###
    ##############################

    source deactivate
else
    #################################
    ### INSTALL PYTHON 3 PACKAGES ###
    #################################

    if [[ "$os" == "linux" ]]; then
        conda install -y theano
        pip install starcluster
    fi

    ##############################
    ### THAT'T IT, YOU'RE DONE ###
    ##############################
fi
