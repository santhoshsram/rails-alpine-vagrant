# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "maier/alpine-3.8-x86_64"
	config.vm.box_version = "3.8.1"

	# Forward traffic from host's port 3000 to guest's port 3000
	config.vm.network "forwarded_port", guest:3000, host: 3000

	# Run the setup script to install ruby, mysql, rails and all
	# their dependencies
	config.vm.provision "shell", path: "provisioners/setup.sh"

	# Machine Configuration
	config.vm.provider "virtualbox" do |v|
		v.name = "rails-mysql-vm"
		v.cpus = "2"
		v.memory = "2048"
		v.linked_clone = "true"
	end
end
