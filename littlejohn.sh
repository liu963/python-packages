# Step 1: Perform all the aptitude updates.
# Various targets:
# - Docker
# - Base Python development
# - Scipy/Numpy dependencies
# - All Java dependencies (Hadoop, Spark, Scala)
# - OpenCV dependencies
apt-get -y update
apt-get -y install \
    build-essential \
    docker.io \
    g++ \
    git \
    python-dev \
    gfortran \
    libblas-dev \
    liblapack-dev \
    libpng12-dev \
    libfreetype6-dev \
    pkg-config \
    libhdf5-dev \
    openjdk-7-jdk \
    unzip \
    wget \
    vim \
    cmake \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libtiff-dev \
    libjasper-dev \
    libdc1394-22-dev \
    libcurl4-nss-dev \
    libsasl2-dev \
    libapr1-dev \
    libsvn-dev \
    maven

# Step 2: Install the various Python packages.
# Various targets:
# - Python ML, data science, imaging, stack analysis, and visualization packages.
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install -r requirements.txt

# Step 3: Download and install the various source files.
# Various targets:
# - Spark, Hadoop, Flink, OpenCV

# Hadoop.
wget http://mirrors.sonic.net/apache/hadoop/common/hadoop-2.7.0/hadoop-2.7.0.tar.gz
tar zxvf hadoop-2.7.0.tar.gz
mkdir hadoop
mv hadoop-2.7.0/ hadoop/
rm hadoop-2.7.0.tar.gz

# Spark.
wget http://mirror.symnds.com/software/Apache/spark/spark-1.4.0/spark-1.4.0-bin-hadoop2.6.tgz
tar zxvf spark-1.4.0-bin-hadoop2.6.tgz
mkdir spark
mv spark-1.4.0-bin-hadoop2.6/ spark/
rm spark-1.4.0-bin-hadoop2.6.tgz

# Scala.
wget http://downloads.typesafe.com/scala/2.10.5/scala-2.10.5.tgz
tar zxvf scala-2.10.5.tgz
mkdir scala
mv scala-2.10.5/ scala/
rm scala-2.10.5.tgz

# OpenCV.
wget https://github.com/Itseez/opencv/archive/3.0.0.zip
mv 3.0.0.zip OpenCV-3.0.0.zip
unzip OpenCV-3.0.0.zip
mkdir opencv
mv opencv-3.0.0/ opencv/
rm OpenCV-3.0.0.zip

# Mesos.
wget http://www.apache.org/dist/mesos/0.22.1/mesos-0.22.1.tar.gz
tar zxvf mesos-0.22.1.tar.gz
mkdir mesos
mv mesos-0.22.1/ mesos/
rm mesos-0.22.1.tar.gz
cd mesos/mesos-0.22.1/
mkdir build
cd build/
../configure
make -j 8 && make check
make install
chmod +x /usr/local/etc/mesos/*.template
mv /usr/local/etc/mesos/mesos-deploy-env.sh.template /usr/local/etc/mesos/mesos-deploy-env.sh
mv /usr/local/etc/mesos/mesos-master-env.sh.template /usr/local/etc/mesos/mesos-master-env.sh
mv /usr/local/etc/mesos/mesos-slave-env.sh.template /usr/local/etc/mesos/mesos-slave-env.sh

