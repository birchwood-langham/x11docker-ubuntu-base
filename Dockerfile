FROM ubuntu:latest

MAINTAINER Tan Quach <tan.quach@birchwoodlangham.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-mark hold iptables && \
    apt-get -y dist-upgrade && apt-get autoremove -y && apt-get clean
RUN apt-get install -y dbus-x11 procps psmisc apt-utils x11-utils x11-xserver-utils kmod xz-utils && \
    apt-get -y install dialog git vim software-properties-common debconf-utils wget curl apt-transport-https bzip2 zip iputils-ping telnet less

# OpenGL / MESA
RUN apt-get install -y mesa-utils mesa-utils-extra libxv1 

# Language/locale settings
#   replace en_US by your desired locale setting, 
#   for example de_DE for german.
ENV LANG en_US.UTF-8
RUN echo $LANG UTF-8 > /etc/locale.gen
RUN apt-get install -y locales && update-locale --reset LANG=$LANG

# some utils to have proper menus, mime file types etc.
RUN apt-get install -y --no-install-recommends xdg-utils xdg-user-dirs \
    menu menu-xdg mime-support desktop-file-utils

# Install fonts
# We just need to drop these into the shared fonts folder, the font cache will be rebuilt when we add the desktop environments
RUN wget https://dl.1001fonts.com/mclaren.zip && \
    unzip -d /usr/share/fonts/truetype/mclaren mclaren.zip && \
    rm mclaren.zip && \
    mkdir -p /usr/share/fonts/truetype/monofur && \
    cd /usr/share/fonts/truetype/monofur && \
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Monofur/Regular/complete/monofur%20Nerd%20Font%20Complete%20Mono.ttf?raw=true -O '/usr/share/fonts/truetype/monofur/monofur Nerd Font Complete Mono.ttf' \
         https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Monofur/Regular/complete/monofur%20Nerd%20Font%20Complete.ttf?raw=true -O '/usr/share/fonts/truetype/monofur/monofur Nerd Font Complete.ttf' \
         https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Monofur/Italic/complete/monofur%20italic%20Nerd%20Font%20Complete%20Mono.ttf?raw=true -O '/usr/share/fonts/truetype/monofur/monofur italic Nerd Font Complete Mono.ttf' \
         https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Monofur/Italic/complete/monofur%20italic%20Nerd%20Font%20Complete.ttf?raw=true -O '/usr/share/fonts/truetype/monofur/monofur italic Nerd Font Complete.ttf' \
         https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Monofur/Bold/complete/monofur%20bold%20Nerd%20Font%20Complete%20Mono.ttf?raw=true -O '/usr/share/fonts/truetype/monofur/monofur bold Nerd Font Complete Mono.ttf.ttf' \
         https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Monofur/Bold/complete/monofur%20bold%20Nerd%20Font%20Complete.ttf?raw=true -O '/usr/share/fonts/truetype/monofur/monofur bold Nerd Font Complete.ttf' 

ENV DEBIAN_FRONTEND newt
