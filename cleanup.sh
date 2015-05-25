#!/bin/bash
# clean up
sudo docker rm `sudo docker ps --no-trunc -a -q`
sudo docker rmi -f busybox
for SERVICE in "chef-client" "puppet"; do
    /usr/sbin/update-rc.d -f $SERVICE remove
    rm /etc/init.d/$SERVICE
    pkill -9 -f $SERVICE
done
sudo apt-get autoremove -y chef puppet
sudo apt-get clean
sudo rm -f \
  /home/vagrant/*.sh       \
  /home/vagrant/.vbox_*    \
  /home/vagrant/.veewee_*  \
  /var/log/messages   \
  /var/log/lastlog    \
  /var/log/auth.log   \
  /var/log/syslog     \
  /var/log/daemon.log \
  /var/log/docker.log


#---------------------------------------#
# Vagrant-specific settings below
#

# add 'vagrant' user to docker group
sudo groupadd docker
sudo gpasswd -a vagrant docker
#sudo usermod -aG docker vagrant


# zero out the free space to save space in the final image
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY


rm -f /home/vagrant/.bash_history  /var/mail/vagrant

sudo cat <<HOSTNAME > /etc/hostname
localhost
HOSTNAME

cat <<EOF  >> /home/vagrant/.bashrc
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
export LC_CTYPE=C.UTF-8
lsb_release -a
EOF