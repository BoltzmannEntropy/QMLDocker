ARG CUDA_VERSION=11.1
ARG OS_VERSION=18.04

#FROM nvcr.io/nvidia/tensorrt:21.07-py3
FROM nvcr.io/nvidia/pytorch:21.07-py3
LABEL maintainer="NVIDIA CORPORATION"

#ENV TRT_VERSION 7.2.3.4
SHELL ["/bin/bash", "-c"]

# Setup user account
ARG uid=1000
ARG gid=1000
RUN groupadd -r -f -g ${gid} qmuser && useradd -o -r -u ${uid} -g ${gid} -ms /bin/bash qmuser
RUN usermod -aG sudo qmuser
RUN echo 'qmuser:qmuser' | chpasswd
#RUN mkdir -p /qml && chown qmuser /qml

ENV TZ=Asia/Dubai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update

# Install requried libraries
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    wget \
    zlib1g-dev \
    git \
    pkg-config \
    sudo \
    ssh \
    libssl-dev \
    pbzip2 \
    pv \
    bzip2 \
    unzip \
    devscripts \
    lintian \
    fakeroot \
    dh-make \
    build-essential


# Install python3
RUN apt-get install -y --no-install-recommends \
      python3 \
      python3-pip \
      python3-dev \
      python3-wheel &&\
    cd /usr/local/bin &&\
    ln -s /usr/bin/python3 python &&\
    ln -s /usr/bin/pip3 pip;

# Install PyPI packages
RUN pip3 install --upgrade pip
RUN pip3 install setuptools>=41.0.0

# Install Cmake
RUN cd /tmp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.20.1/cmake-3.20.1-Linux-x86_64.sh && \
    chmod +x cmake-3.20.1-Linux-x86_64.sh && \
    ./cmake-3.20.1-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir --skip-license && \
    rm ./cmake-3.20.1-Linux-x86_64.sh

USER root
# Jupyter
RUN pip  install -U  pandas jupyter ipywidgets sklearn matplotlib  ipython  ipykernel
# Set working dir

#RUN mkdir ~/.jupyter/
RUN python3 -m pip install ipykernel 
RUN python3 -m ipykernel install --user 
RUN python3 -m ipykernel.kernelspec 
RUN jupyter nbextension enable --py widgetsnbextension 
USER qmuser 
RUN jupyter notebook --generate-config 

USER qmuser
#RUN add jupyter_notebook_config.py
COPY jupyter_notebook_config.py /home/qmuser/.jupyter/jupyter_notebook_config.py
COPY run_jupyter.sh /home/qmuser/
WORKDIR "/" 
USER root
RUN chmod +x /home/qmuser/run_jupyter.sh


RUN pip install -U scikit-image onnxruntime librosa
RUN python3.8 -m pip install torch torchvision torchaudio pyyaml humanfriendly torch-complex tqdm webrtcvad
WORKDIR /

RUN apt-get install -y --no-install-recommends libcairo2 texlive-xetex texlive-fonts-recommended texlive-plain-generic

RUN apt-get update \
    && apt-get install -y openssh-server xauth \
    && mkdir /var/run/sshd \
    && mkdir /root/.ssh \
    && chmod 700 /root/.ssh \
    #&& mkdir /root/.ssh/authorized_keys \
    && ssh-keygen -A \
    && sed -i "s/^.*ClientAliveInterval.*$/ClientAliveInterval 120/" /etc/ssh/sshd_config \
    && sed -i "s/^.*ClientAliveCountMax.*$/ClientAliveCountMax 720/" /etc/ssh/sshd_config \
    && sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
    && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config


RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXzdf8v1f/R/DWV1UpJF/yxSessUC44kueQgs8fceWEncC3gUC174S7YfCff8Oas1lfCVFCJJZdmbSEExuw+YaLxyJ633RIHtAgAP+TJzl90UBys9iPxL66I4r7SzOXd3oYgyonUfMLADIWYAjkErvx4N8UHPNNe1yC8jBtT+7LDNZL4dVZ4iodfs8gQfSxN5UuPkIb04ali6chfvx3PADrfFWC8meYPfDxAqiz4h9U7DywgoXwMwWAc4J9Tbbg7Jztjz0xCWlrUjiif5hXbKcgDKv5fltwYVIPA2XU+I+zS3reegYWWiHxfpGf2V1Ym6sGIhJNsccjlLzEKq57gg1 dambo" >> /root/.ssh/authorized_keys
RUN echo 'ldconfig'  >> /root/.bashrc
# RUN source /root/.bashrc
RUN echo "export PATH=$PATH" >> /etc/profile && \
    echo "ldconfig" >> /etc/profile

#QUANTUM
#RUN apt-get install -y apt-transport-https curl gnupg \
#RUN wget https://github.com/bazelbuild/bazel/releases/download/3.7.2/bazel-3.7.2-linux-arm64 && chmod +x ./bazel-3.7.2-linux-arm64
#RUN cp ./bazel-3.7.2-linux-arm64 /usr/local/bin/bazel
#WORKDIR /
# A fix for OSX m1 chip
#RUN python3 -m pip download paddlepaddle==2.3.2 -f https://www.paddlepaddle.org.cn/whl/linux/openblas/avx/stable.html --no-index --no-deps
RUN python3.8 -m pip install -U qiskit cirq qibo git+https://github.com/aspuru-guzik-group/tequila.git azure-quantum[qiskit]
# see python -m pip install paddlepaddle==2.4.1 -i https://pypi.tuna.tsinghua.edu.cn/simple
# see https://stackoverflow.com/questions/74319979/how-to-install-paddlepaddle-with-no-avx-core
RUN python3.8 -m pip download paddlepaddle==2.3.0 -f https://www.paddlepaddle.org.cn/whl/linux/mkl/noavx/stable.html --no-index --no-deps
RUN python3.8 -m pip install paddlepaddle-2.3.0-cp38-cp38-linux_x86_64.whl paddle-quantum==2.2.2
#RUN python3.8 -m pip install "opencv-python-headless<4.3"

RUN apt-get install -y libx11-dev ffmpeg libsm6 libxext6 libgl1 python3-opencv
RUN python3.8 -m pip install opencv-python opencv-contrib-python==4.5.5.62 pillow==9.1.0 celluloid

USER root
RUN chown qmuser /home/qmuser/
RUN chown -R qmuser:qmuser /home/qmuser/
USER qmuser
WORKDIR /home/qmuser
RUN git clone https://github.com/PaddlePaddle/Quantum.git
RUN git clone https://github.com/theerfan/Q/

RUN ["/bin/bash"]
EXPOSE 8097 7842