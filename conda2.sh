conda update -y --all

# Core packages.
conda install --yes \
    blaze-core \
    cython \
    dask \
    decorator \
    freetype \
    future \
    ipython \
    jupyter \
    libpng \
    libsodium \
    libtiff \
    libxml2 \
    llvmlite \
    numpy \
    pandas \
    toolz \
    tornado \
    twisted \
    xray

# Introspection.
conda install --yes \
    bottleneck \
    numba \
    pep8

# Frameworks.
conda install --yes \
    dask \
    joblib

# Scientific computing.
conda install --yes \
    astropy \
    beautiful-soup \
    gensim \
    nltk \
    pyamg \
    scikit-image \
    scikit-learn \
    scipy \
    shapely

# Visualization.
conda install --yes \
    bokeh \
    click \
    matplotlib \
    seaborn

# APIs.
conda install --yes \
    pillow \
    protobuf

# Storage.
conda install --yes \
    h5py \
    hdf5 \
    sqlalchemy \
    sqlite

# Now, everything else.
pip install -r requirements2.txt
