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
bin="Miniconda-latest-${f}-x86_64.sh"
url="https://repo.continuum.io/miniconda/${bin}"
wget $url
chmod +x $bin && ./${bin} -b -p $prefix
export PATH=${prefix}/bin:$PATH

# Update everything.
conda update -y --all

# Add the condarc file.
mv condarc $prefix
conda env update
if [[ "$py2" == true ]]; then
    conda env create -n python2
    source activate python2
    pip install -r requirements.txt
    if [[ "$os" == "linux" ]]; then
        pip install starcluster
        pip install opencv
    fi

    # Install any Python 2-specific packages.
    pip install thunder-python

    source deactivate
fi

# Now, everything else.
pip install -r requirements.txt
if [[ "$os" == "linux" ]]; then
    pip install starcluster
    pip install opencv
fi
