# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :master do |master_config|
    master_config.vm.box = "ubuntu/trusty64"
    master_config.vm.network "private_network", ip: "192.168.50.10"
    master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
    master_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"
    master_config.landrush.enabled = true
    master_config.landrush.tld = "master"
    master_config.vm.hostname = "master"
    master_config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
    end

    master_config.vm.provision :salt do |salt|
      salt.master_config = "saltstack/etc/master"
      salt.minion_config = "saltstack/etc/master_minion"
      salt.master_key = "saltstack/keys/master_minion.pem"
      salt.master_pub = "saltstack/keys/master_minion.pub"
      salt.minion_key = "saltstack/keys/master_minion.pem"
      salt.minion_pub = "saltstack/keys/master_minion.pub"

      salt.seed_master = {
                          "minion1" => "saltstack/keys/minion1.pub",
                          "minion2" => "saltstack/keys/minion2.pub"
                         }

      salt.install_type = "stable"
      salt.install_master = true
      salt.no_minion = false
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

  config.vm.define :minion1 do |minion_config|
    minion_config.vm.box = "ubuntu/trusty64"
    minion_config.vm.network "private_network", ip: "192.168.50.11"
    minion_config.landrush.enabled = true
    minion_config.landrush.tld = "minion1"
    minion_config.vm.hostname = "minion1"
    #Kibana port
    minion_config.vm.network "forwarded_port", guest: 5601, host: 5601, auto_correct: true
    minion_config.vm.network "forwarded_port", guest: 9200, host: 9200, auto_correct: true

    minion_config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
    end

    minion_config.vm.provision :salt do |salt|
      salt.minion_config = "saltstack/etc/minion1"
      salt.minion_key = "saltstack/keys/minion1.pem"
      salt.minion_pub = "saltstack/keys/minion1.pub"
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

  config.vm.define :minion2 do |minion_config|
    minion_config.vm.box = "ubuntu/trusty64"
    # The following line can be uncommented to use Centos
    # instead of Ubuntu.
    # Comment out the above line as well
    #minion_config.vm.box = "bento/centos-7.2"
    minion_config.landrush.enabled = true
    minion_config.landrush.tld = "minion2"
    minion_config.vm.hostname = "minion2"
    minion_config.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true

    minion_config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
    end

    minion_config.vm.network "private_network", ip: "192.168.50.12"

    minion_config.vm.provision :salt do |salt|
      salt.minion_config = "saltstack/etc/minion2"
      salt.minion_key = "saltstack/keys/minion2.pem"
      salt.minion_pub = "saltstack/keys/minion2.pub"
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

end
