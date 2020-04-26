require 'json'

config_data = JSON.parse(File.read('config.json'))
net_adapter = "en1: Wi-Fi (AirPort)" # Change this according to your PC
vm_data_folder = "/home/vagrant/data"

Vagrant.configure(2) do |config|
  config.vm.provider :virtualbox do |v, override|
    config.vm.box = "ubuntu/bionic64"

    v.customize ["modifyvm", :id, "--memory", config_data["mem"]]
    v.customize ["modifyvm", :id, "--cpus", config_data["cpus"]]

    override.vm.network :public_network, bridge: net_adapter, ip: "#{config_data["ip"]}"
    override.vm.hostname = config_data["hostname"]
    v.name = config_data["hostname"]

    # Uncomment this if you want storage outside the VM.
    # WARNING: Feature not yet supported, as it makes Artifactory startup fail
    config.vm.synced_folder "./data", vm_data_folder, mount_options: ["dmode=777,fmode=777"]
  end

  config.vm.provision "file", source: "./provision", destination: '/home/vagrant/provision'
  config.vm.provision "shell", path: "./provision/provision.sh", :args => [config_data["ip"]]

end
