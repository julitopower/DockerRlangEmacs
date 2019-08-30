FROM r-base:latest

MAINTAINER Julio Delgado <julio.delgadomangas@gmail.com>

# Enable 256 ANSI colors for Emacs
ENV TERM xterm-256color
ENV HOME /root
ENV PATH ${PATH}:/root/.local/bin

# Install emacs26
RUN apt-get update -y && apt-get install software-properties-common -y \
    && apt-get install emacs sudo -y


# Cleanup and create passwordless sudo
RUN rm -rf /var/lib/apt/lists/* \
    && sed -i "s/root\sALL=(ALL:ALL ) ALL/ALL    ALL = (ALL) NOPASSWD: ALL   /" /etc/sudoers \
    && touch /root/.emacs \
    && mkdir /root/.emacs.d

# Make emacs configuration available and run emacs once so that
# packages get installed
COPY emacs.d ${HOME}/.emacs.d
RUN rm -rf ${HOME}/.emacs && emacs --batch -l ${HOME}/.emacs.d/init.el

WORKDIR /opt/src/
