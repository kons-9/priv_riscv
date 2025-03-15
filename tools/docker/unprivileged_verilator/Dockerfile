ARG VERILATOR_VERSION
FROM verilator/verilator:v${VERILATOR_VERSION}

ARG USER_ID
ARG GROUP_ID

RUN groupadd -g $GROUP_ID work
RUN useradd -m -s /bin/bash -u $USER_ID -g $GROUP_ID work
RUN echo "work ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chown -R work:work /home/work
RUN passwd -d root

#home directory
ARG PROJECT_ROOT

RUN git config --global --add safe.directory $PROJECT_ROOT

# USER work
WORKDIR $PROJECT_ROOT
USER work

ENTRYPOINT [ "/usr/local/bin/verilator-wrap.sh" ]
