VAGRANTFILE_API_VERSION = "2"
cluster = {
   "linux1"         => { :box => "centos/7", :ip_pri => "192.168.0.101", :ip_pub => "10.0.0.101", :cpus => 4, :mem => 4096,  :extdiskfile => '/gpfs/photonics/swissfel/res/dorigo_a/disk-lnx1.vdi', :dsize => 40},
   "linux2"         => { :box => "centos/7", :ip_pri => "192.168.0.102", :ip_pub => "10.0.0.102", :cpus => 8, :mem => 8192,  :extdiskfile => '/gpfs/photonics/swissfel/res/dorigo_a/disk-lnx1.vdi', :dsize => 80}
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  cluster.each_with_index do |(hostname, info), index|
    config.vm.synced_folder "./", "/vagrant", disabled: false
    config.vm.define hostname do |cfg|

      cfg.vm.provider :virtualbox do |vb, override|
        config.vm.box = hostname
        override.vm.network :private_network, ip: "#{info[:ip_pri]}"
        override.vm.network :public_network, ip: "#{info[:ip_pub]}"
        override.vm.hostname = hostname
        vb.name = hostname
	File.delete( info[:extdiskfile] ) if File.exist?( info[:extdiskfile] )
	vb.customize ['createhd', '--filename', info[:extdiskfile], '--size', info[:dsize] * 1024]
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
	vb.customize ["storagectl", :id, "--name", "SATA Controller", "--add", "sata"]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 0, '--device', 0, '--type', 'hdd', '--medium', info[:extdiskfile]]
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
      end # end cfg.vm.provider
      cfg.vm.box = "#{info[:box]}"
#      cfg.ssh.username = 'root'
#      cfg.ssh.password = 'vagrant'
#      cfg.ssh.insert_key = 'true'
      cfg.ssh.forward_agent = true
      cfg.ssh.forward_x11 = true
      cfg.ssh.insert_key = false
      cfg.vm.provision "shell", inline: 'sudo /vagrant/copy-init.sh'
#      cfg.vm.provision "file", source: "cluster-init.sh", destination: "/root/cluster-init.sh"
    end # end config
  end # end cluster loop

end # end configure
