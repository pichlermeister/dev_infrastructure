Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 4
    #vb.gui = true

    # This allows symlinks to be created within the /vagrant root directory,
    # which is something librarian-puppet needs to be able to do. This might
    # be enabled by default depending on what version of VirtualBox is used.
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  config.vm.define "build" do |machine|
    machine.vm.hostname = "build.local"
    machine.vm.network "private_network", ip: "192.168.99.10"
    machine.hostsupdater.aliases = ["sonar.local","nexus.local","jenkins.local", "gitlab.local"]
  end

#  config.vm.define "app1" do |machine|
#    config.vm.provider "virtualbox" do |vb|
#      vb.memory = 1024
#    end
#
#    machine.vm.hostname = "app1.local"
#    machine.vm.network "private_network", ip: "192.168.99.21"
#    machine.hostsupdater.aliases = ["app1.local"]
#  end

  #config.hostsupdater.remove_on_suspend = true

  #config.vm.provision "shell", inline: "sudo apt-get update"

  # This shell provisioner installs librarian-puppet and runs it to install
  # puppet modules. This has to be done before the puppet provisioning so that
  # the modules are available when puppet tries to parse its manifests.
  config.vm.provision :shell do |shell|
    shell.path = "puppet/librarian-puppet.sh"
  # uncomment the next line if you want to install the librarian-ruby gem instead the package
  # neccessary for ubuntu/trusty64 as it would otherwise install a pretty old version
    shell.args = "-g"

  end


  # Now run the puppet provisioner. Note that the modules directory is entirely
  # managed by librarian-puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "main.pp"
    puppet.hiera_config_path = "puppet/hiera.yaml"
  end


  #config.vm.synced_folder "docker-volumes", "/var/lib/docker/volumes", create: true


end
