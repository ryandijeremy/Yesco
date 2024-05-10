FROM ubuntu:22.04
# update and install software
RUN export DEBIAN_FRONTEND=noninteractive  \
	&& apt-get update -qy \
	&& apt-get full-upgrade -qy \
	&& apt-get dist-upgrade -qy \
	&& apt-get install -qy \
     sudo pulseaudio cups supervisor wget curl unzip tar git xz-utils apt-utils openssh-server build-essential software-properties-common

# user and groups
ENV USER shakugan
ENV PASSWORD AliAly032230
RUN useradd -m -s /bin/bash ${USER} \
    && usermod -append --groups sudo ${USER} \
    && echo "${USER}:${PASSWORD}" | chpasswd \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    
WORKDIR /home/${USER}

RUN wget https://github.com/openziti/zrok/releases/download/v0.4.26/zrok_0.4.26_linux_amd64.tar.gz \
    && tar -xf zrok_0.4.26_linux_amd64.tar.gz \
    && chmod +x zrok \
    && mv zrok /usr/local/bin/zrok \
    && rm -rf zrok zrok_0.4.26_linux_amd64.tar.gz

RUN wget https://github.com/coder/code-server/releases/download/v4.22.1/code-server_4.22.1_amd64.deb \
    && dpkg -i code-server_4.22.1_amd64.deb 

# set owner
RUN chown -R ${USER}:${USER} /home/${USER}/.*
USER shakugan
RUN zrok enable G6428yXYqQxn

EXPOSE 10000

# default command
CMD code-server --bind-addr 127.0.0.1:10000 --auth none & zrok share public localhost:10000
