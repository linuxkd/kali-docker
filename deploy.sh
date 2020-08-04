sudo yum update -y
sudo yum install -y docker git
sudo service docker start

sudo docker build -t kali https://raw.githubusercontent.com/linuxkd/kali-docker/master/Dockerfile

KALI_ROOT="/pentest/kali-root"

sudo mkdir -p $KALI_ROOT
sudo chmod 777 $KALI_ROOT
git clone https://github.com/atucom/dotfiles $KALI_ROOT/atu-dotfiles
curl -s https://raw.githubusercontent.com/linuxkd/dotfiles/master/.zshrc_docker --output $KALI_ROOT/.zshrc
curl -s https://gist.githubusercontent.com/linuxkd/9ac20377c4518ba4d76751465391dfa4/raw/61d9487f82810279b6b7f2231b695b42c3a3d2ed/kali-bashrc --output $KALI_ROOT/.bashrc

# BASH Default
echo 'sudo alias kali="docker run -p 53:53 -p 53:53/udp -p 80:80 -p 443:443 -p 4444:4444 -p 5555:5555 -p 8080:8080 -p 8443:8443 -e TZ=America/New_York -ti --rm --mount type=bind,src=/pentest/kali-root,dst=/root --mount src=kali-postgres,dst=/var/lib/postgresql kali bash"' | sudo tee -a /etc/skel/.bashrc
echo 'sudo alias kali-zsh="docker run -p 53:53 -p 53:53/udp -p 80:80 -p 443:443 -p 4444:4444 -p 5555:5555 -p 8080:8080 -p 8443:8443 -e TZ=America/New_York -ti --rm --mount type=bind,src=/pentest/kali-root,dst=/root --mount src=kali-postgres,dst=/var/lib/postgresql kali zsh"' | sudo tee -a /etc/skel/.bashrc

# ZSH Default
echo 'alias kali="sudo docker run -p 53:53 -p 53:53/udp -p 80:80 -p 443:443 -p 4444:4444 -p 5555:5555 -p 8080:8080 -p 8443:8443 -e TZ=America/New_York -ti --rm --mount type=bind,src=/pentest/kali-root,dst=/root --mount src=kali-postgres,dst=/var/lib/postgresql kali bash"' | tee -a ~/.bashrc
echo 'alias kali-zsh="sudo docker run -p 53:53 -p 53:53/udp -p 80:80 -p 443:443 -p 4444:4444 -p 5555:5555 -p 8080:8080 -p 8443:8443 -e TZ=America/New_York -ti --rm --mount type=bind,src=/pentest/kali-root,dst=/root --mount src=kali-postgres,dst=/var/lib/postgresql kali zsh"' | tee -a ~/.bashrc
