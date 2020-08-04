# base kali-rolling image to start with
FROM kalilinux/kali-rolling:latest

# don't prompt for apt stuffs
ENV DEBIAN_FRONTEND noninteractive

# install the tools
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get clean
RUN apt install -y kali-tools-top10 kali-tools-web kali-tools-passwords man-db exploitdb python3-pexpect python3-bs4 tmux screen zsh neovim python2 awscli python3-boto3 azure-cli python3-azure

# set python3 as default for python
RUN ln -s /usr/bin/python3 /usr/bin/python

# initialize Metasploit database
RUN service postgresql start && msfdb init && service postgresql stop
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

WORKDIR /root
CMD ["/bin/bash"]
