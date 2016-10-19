Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 3072
    vb.cpus = 2

    # This allows symlinks to be created within the /vagrant root directory, 
    # which is something librarian-puppet needs to be able to do. This might
    # be enabled by default depending on what version of VirtualBox is used.
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end
  
  config.vm.define "git" do |machine|
    machine.vm.hostname = "git.local"
    machine.vm.network "private_network", ip: "192.168.99.8"
    machine.hostsupdater.aliases = ["git.local"]
  end
  config.vm.define "build" do |machine|
    machine.vm.hostname = "build.local"
    machine.vm.network "private_network", ip: "192.168.99.10"
    machine.hostsupdater.aliases = ["build.local"]
  end
  config.vm.define "app1" do |machine|
    config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
  	end
  	
    machine.vm.hostname = "app1.local"
    machine.vm.network "private_network", ip: "192.168.99.21"
    machine.hostsupdater.aliases = ["app1.local"]
  end
  config.vm.define "app2" do |machine|
    machine.vm.hostname = "app2.local"
    machine.vm.network "private_network", ip: "192.168.99.22"
    #machine.hostsupdater.aliases = ["app2.local"]
  end
  #config.hostsupdater.remove_on_suspend = true

  #config.vm.provision "shell", inline: "sudo apt-get update"
  
  # This shell provisioner installs librarian-puppet and runs it to install
  # puppet modules. This has to be done before the puppet provisioning so that
  # the modules are available when puppet tries to parse its manifests.
  config.vm.provision :shell do |shell|
    shell.path = "puppet/librarian-puppet.sh"
  # uncomment the next line if you want to install the librarian-ruby gem instead the package
  #  shell.args = "-g"
  end

  # Now run the puppet provisioner. Note that the modules directory is entirely
  # managed by librarian-puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "main.pp"
    puppet.hiera_config_path = "puppet/hiera.yaml"
  end
  
  
#  config.vm.provision "puppet" do |puppet|
#    puppet.module_path = "puppet/modules"
#    puppet.manifests_path = "puppet/"
#    puppet.manifest_file = "site.pp"
#	puppet.hiera_config_path = "puppet/hiera.yaml"
#  end
end