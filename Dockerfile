FROM ubuntu:20.04

# Needed for X11 forwarding
ENV DISPLAY :0

# Needed for X11 forwarding
ENV USERNAME developer

WORKDIR /app

RUN apt update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-transport-https \
    software-properties-common 

# Add neovim repository
RUN add-apt-repository ppa:neovim-ppa/stable -y

RUN apt update

# install neovim
RUN DEBIAN_FRONTEND=noninteractive apt install -yq neovim

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME root

USER $USERNAME

WORKDIR /home/$USERNAME

CMD "nvim"