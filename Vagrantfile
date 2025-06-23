Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = "20240821.0.1"

  config.vm.define "db" do |db_config|
    db_config.vm.network "private_network", ip: "192.168.56.10"
  end

  config.vm.define "web" do |web_config|
    web_config.vm.network "private_network", ip: "192.168.56.11"
  end

  
end
