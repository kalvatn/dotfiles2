# vi: set ft=ruby:
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/zesty64"
  config.ssh.insert_key = true

  config.vm.provider :virtualbox do |vb|
    vb.name = "vagrant_dotfiles_ubuntu_zesty64"
    vb.memory = 512
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.hostname = "vagrant-dotfiles-ubuntu-zesty64"
  config.vm.network :private_network, ip: "10.3.3.3"
  config.vm.synced_folder ".", "/home/ubuntu/dotfiles"

  config.vm.define :vagrant_dotfiles_ubuntu_zesty64 do |m|
    m.vm.provision "shell", inline: "apt-get update && apt-get -y install ansible dnsmasq"

    # m.vm.provision "ansible_local" do |ansible|
    #   ansible.playbook = "/home/ubuntu/dotfiles/provisioning/ansible/vagrant-playbook.yml"
    #   ansible.inventory_path = "/home/ubuntu/dotfiles/provisioning/ansible/hosts"
    # end
  end

end

