FROM ubuntu:24.04
ARG USER_ID
ARG GROUP_ID
ARG VERILATOR_VERSION

USER root

RUN userdel -f $(getent passwd $USER_ID | cut -d: -f1)

ENV HOME=/home/work

RUN apt-get update && apt-get install -y \
    python3-dev \
    python3-venv \
    python3-pip \
    gcc \
    g++ \
    git \
    make \
    curl \
    sudo

# python packages
# RUN pip install --upgrade pip --break-system-packages
# COPY ./requirements.txt .
# RUN pip install -r requirements.txt --break-system-packages

# verilator
WORKDIR /home/work/
RUN apt-get install git help2man perl python3 make autoconf g++ flex bison ccache libgoogle-perftools-dev numactl perl-doc libfl2 libfl-dev zlib1g zlib1g-dev -y

RUN git config --global --add safe.directory /home/work/
RUN git config --global --add safe.directory /home/work/verilator

RUN git clone https://github.com/verilator/verilator

WORKDIR /home/work/verilator
RUN git checkout v${VERILATOR_VERSION}
RUN unset VERILATOR_ROOT
RUN autoconf
RUN ./configure
RUN make -j$(nproc)
RUN make install

RUN rm -rf /home/work/.cache

RUN mkdir -p /home/work/
RUN groupadd -g $GROUP_ID work
RUN useradd -m -s /bin/bash -u $USER_ID -g $GROUP_ID work
RUN chown -R work:work /home/work
RUN echo "work ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER work

WORKDIR /home/work/

