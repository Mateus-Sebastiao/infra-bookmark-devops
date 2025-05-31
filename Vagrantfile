Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = "20240821.0.1"

  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provision "shell", path: "provision.sh"
  
end
