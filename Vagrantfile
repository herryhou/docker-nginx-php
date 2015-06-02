# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # maxwin demo boxes
  num_nodes = (ENV['NODES_NO'] || 1).to_i
  #base_ip = "10.1.1."

  num_nodes.times do |n|
    config.vm.define "maxwin-#{n+1}" do |maxwin|
      maxwin.vm.box = "debian/jessie64"

      #ip = "base_ip.#{n+100}"
      maxwin.vm.network :private_network, ip: "10.1.1.#{n+100}"
      maxwin.vm.network "forwarded_port", guest: 80, host: n+8000
      maxwin_index = n+1
      maxwin.vm.hostname = "maxwin-#{maxwin_index}"
      maxwin.ssh.password = "vagrant"
      maxwin.vm.provision :shell, :path => "install_docker.sh"
      maxwin.vm.provision :shell, :path => "cleanup.sh"
      maxwin.vm.provision :shell, :inline => "cd /vagrant && docker-compose up -d"
    end
  end
end





