VAGRANTFILE_API_VERSION = "2"

storage='/gpfs/photonics/swissfel/res/dorigo_a/VirtualBox'
#memory=2048
#cores=2
#disksize=100

ansibleservers = {
  "control" => { :box => "centos/8", :ip_pri => "192.168.1.10", :ip_pub => "10.0.1.10", :cpus => 1, :mem => 2048, :provisioning_script => "scripts/setup-ansible-server.sh", :d1 => "#{storage}/disk-control-extidio.vdi", :dsize => 1 },
  "server1" => { :box => "centos/8", :ip_pri => "192.168.1.11", :ip_pub => "10.0.1.11", :cpus => 1, :mem => 1024, :provisioning_script => "scripts/setup-server.sh", :d1 => "#{storage}/disk-managedidio-1.vdi", :dsize => 40 },
  "server2" => { :box => "centos/8", :ip_pri => "192.168.1.12", :ip_pub => "10.0.1.12", :cpus => 1, :mem => 1024, :provisioning_script => "scripts/setup-server.sh", :d1 => "#{storage}/disk-managedidio-2.vdi", :dsize => 40 },
  "server3" => { :box => "centos/8", :ip_pri => "192.168.1.13", :ip_pub => "10.0.1.13", :cpus => 1, :mem => 1024, :provisioning_script => "scripts/setup-server.sh", :d1 => "#{storage}/disk-managedidio-3.vdi", :dsize => 40 },
  "server4" => { :box => "centos/8", :ip_pri => "192.168.1.14", :ip_pub => "10.0.1.14", :cpus => 1, :mem => 1024, :provisioning_script => "scripts/setup-server.sh", :d1 => "#{storage}/disk-managedidio-4.vdi", :dsize => 40 }
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ansibleservers.each_with_index do |(hostname, info), index|
    config.vm.synced_folder "./", "/vagrant", disabled: false
    config.vm.define hostname do |cfg|
      cfg.vm.provider :virtualbox do |vb, override|
        config.vm.box = hostname
        override.vm.network :private_network, ip: "#{info[:ip_pri]}"
        override.vm.network :public_network, ip: "#{info[:ip_pub]}"
        override.vm.hostname = hostname
        vb.name = hostname

        vb.customize ['createhd', '--filename', info[:d1], '--size', info[:dsize] * 1024]
#        vb.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', info[:d1]]

        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
	vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
      end # end cfg.vm.provider
      cfg.vm.box = "#{info[:box]}"
      cfg.vm.provision "shell", path: "#{info[:provisioning_script]}"
      cfg.ssh.forward_agent = true
      cfg.ssh.forward_x11 = true
      cfg.ssh.keep_alive = true
      cfg.ssh.forward_agent = true
      cfg.ssh.forward_x11 = true
    end
  end # end cluster loop

end # end configure
