Vagrant.configure("2") do |config|
    config.vm.box = "archlinux/archlinux"
    config.vm.network "forwarded_port", guest: 9000, host: 9000
    config.vm.network "forwarded_port", guest: 9001, host: 9001
    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.customize ["modifyvm", :id, "--cableconnected1", "on"]
    end
    config.vm.provision "shell", inline: "echo Y | pacman -Sy vim docker docker-compose make && systemctl start docker"
end