# Dockerfile for running Kali with a reasonable number of tools installed in docker in a sane manner.
# Drew Blokzyl (@linuxkd)
# https://github.com/linuxkd/kali-docker

# base kali-rolling image to start with
FROM kalilinux/kali-rolling:latest

# don't prompt for apt stuffs
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

# prep for install
RUN apt update -y && apt dist-upgrade -y

# build our locale before going through our installs
RUN apt install -y locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen

# install the tools
RUN apt install -y kali-tools-top10 kali-tools-web kali-tools-passwords man-db exploitdb python3-pexpect python3-bs4 tmux screen zsh neovim python2 awscli python3-boto3 azure-cli python3-azure

# set python3 as default for python
RUN ln -s /usr/bin/python3 /usr/bin/python

# initialize Metasploit database
RUN service postgresql start && msfdb init && service postgresql stop

# Grab some sane default configs
RUN git clone https://github.com/atucom/dotfiles /root/atu-dotfiles
RUN curl -s https://raw.githubusercontent.com/linuxkd/dotfiles/master/.zshrc_docker --output /root/.zshrc
RUN curl -s https://gist.githubusercontent.com/linuxkd/9ac20377c4518ba4d76751465391dfa4/raw/61d9487f82810279b6b7f2231b695b42c3a3d2ed/kali-bashrc --output /root/.bashrc

# Copy all of our stuff to the host and expose as a volume
VOLUME /root /var/lib/postgresql

# expose common ports
EXPOSE 53
EXPOSE 53/udp
EXPOSE 80
EXPOSE 443
EXPOSE 4444
EXPOSE 5555
EXPOSE 8080
EXPOSE 8443

# set our common entry point and set init for docker start
WORKDIR /root
CMD ["/sbin/init"]
