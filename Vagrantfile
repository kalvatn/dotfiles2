# vi: set ft=ruby:
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/zesty64"
  # config.ssh.insert_key = false
  # config.ssh.username = "kalvatn"
  # config.ssh.password = ""
  # config.ssh.username = "ubuntu"
  # config.ssh.password = "15cc9c697918779c27a0bb20"

  config.vm.provider :virtualbox do |vb|
    vb.name = "vagrant_dotfiles_ubuntu_zesty64"
    vb.memory = 512
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.hostname = "vagrant-dotfiles-ubuntu-zesty64"
  config.vm.network :private_network, ip: "192.168.33.33"

  config.vm.define :vagrant_dotfiles_ubuntu_zesty64 do |vagrant_dotfiles_ubuntu_zesty64|
  end

  config.vm.synced_folder ".", "/home/vagrant/dotfiles"

  # config.vm.provision "ansible_local" do |ansible|
  #   ansible.playbook = "/home/vagrant/dotfiles/provision/ansible/vagrant-playbook.yml"
  #   ansible.inventory_path = "/home/vagrant/dotfiles/provision/ansible/hosts"
  # end
end

