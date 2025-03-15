ARG VERILATOR_VERSION
FROM verilator/verilator:v${VERILATOR_VERSION}

ARG USER_ID
ARG GROUP_ID

RUN groupadd -g $GROUP_ID work
RUN useradd -m -s /bin/bash -u $USER_ID -g $GROUP_ID work
RUN chown -R work:work /home/work
RUN echo "work ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN passwd -d root
RUN git config --global --add safe.directory /work

# USER work
WORKDIR /work

ENTRYPOINT []
