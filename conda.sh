#!/bin/bash

# Anaconda environment setup script. Basically, it installs core Miniconda,
# then fires up an accompanying Python script to handle the rest of the
# customized install.

#############################
### CONFIGURATION OPTIONS ###
#############################

# Set up defaults.

# Can be "Linux" or "MacOSX"
OS_VERSION="Linux"
#OS_VERSION="MacOSX"

# Can be anywhere on the filesystem.
INSTALL_PREFIX="/opt/python"

# Can be 2 or 3.
PYTHON_VERSION="3"
#PYTHON_VERSION="2"

##############################
### THAT'T IT, YOU'RE DONE ###
##############################

# Download the corresponding Miniconda installer.

bin="Miniconda3-latest-${OS_VERSION}-x86_64.sh"
url="https://repo.continuum.io/miniconda/${bin}"
#curl -O $url
wget $url
chmod +x $bin && ./${bin} -f -b -p $prefix && rm ./${bin}
export PATH=${prefix}/bin:$PATH

# Update everything.
conda update -y --all

# Should we create a Python 2 environment?
if [[ "$PYTHON_VERSION" == "2" ]]; then
    conda create -y -n py2 python=2
fi

# Fire up the Python install script.
python install.py -v ${PYTHON_VERSION} -p ${PYTHON_VERSION} -o ${OS_VERSION}
