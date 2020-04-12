Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.network "forwarded_port", guest: 8081, host: 8081
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "file", source: "./provision/artifactory/backup.zip", destination: '/home/vagrant/provision/backup.zip'
  config.vm.provision "file", source: "./provision/artifactory/restore.sh", destination: '/home/vagrant/provision/restore.sh'
  config.vm.provision "file", source: "./provision/artifactory/cleanup.sh", destination: '/home/vagrant/provision/cleanup.sh'
  config.vm.provision "file", source: "./provision/provision.sh", destination: '/home/vagrant/provision/provision.sh'
  config.vm.provision "file", source: "./artifactory-postgres.yml", destination: '/home/vagrant/provision/docker-compose.yml'

  config.vm.provision "shell", path: "./provision/install-docker.sh"
  config.vm.provision "shell", path: "./provision/provision.sh"

end
