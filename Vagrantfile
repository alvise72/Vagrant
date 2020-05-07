VAGRANTFILE_API_VERSION = "2"

storage='/gpfs/photonics/swissfel/res/dorigo_a/VirtualBox'
CONTROLLER = ENV.fetch('CONTROLLER', 'IDE Controller')
#memory=2048
#cores=2
#disksize=100

ansibleservers = {
  "control" => { :box => "centos/8", :ip_pri => "192.168.1.10", :ip_pub => "10.0.1.10", :cpus => 1, :mem => 2048, :provisioning_script => "scripts/setup-ansible-server.sh", :d1 => "#{storage}/control.vdi", :dsize => 1, :controller => "IDE", :port => 0, :device => 1 },
  "server1" => { :box => "centos/8", :ip_pri => "192.168.1.11", :ip_pub => "10.0.1.11", :cpus => 1, :mem => 1024, :provisioning_script => "scripts/setup-server.sh", :d1 => "#{storage}/server1.vdi", :dsize => 40, :controller => "IDE", :port => 0, :device => 1 },
  "server2" => { :box => "centos/8", :ip_pri => "192.168.1.12", :ip_pub => "10.0.1.12", :cpus => 1, :mem => 1024, :provisioning_script => "scripts/setup-server.sh", :d1 => "#{storage}/server2.vdi", :dsize => 40, :controller => "IDE", :port => 0, :device => 1 },
  "server3" => { :box => "centos/8", :ip_pri => "192.168.1.13", :ip_pub => "10.0.1.13", :cpus => 1, :mem => 1024, :provisioning_script => "scripts/setup-server.sh", :d1 => "#{storage}/server3.vdi", :dsize => 40, :controller => "IDE", :port => 0, :device => 1 },
  "server4" => { :box => "debian/jessie64", :ip_pri => "192.168.1.14", :ip_pub => "10.0.1.14", :cpus => 1, :mem => 1024, :provisioning_script => "scripts/setup-server.sh", :d1 => "#{storage}/server4.vdi", :dsize => 40, :controller => "SATA Controller", :port => 1, :device => 0 }
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
        if !File.exist?(info[:d1])
          vb.customize ['createhd', '--filename', info[:d1], '--size', info[:dsize] * 1024]
          vb.customize ['modifyhd', info[:d1], '--type', 'writethrough']
        end
#        vb.customize ['storageattach', :id, '--storagectl', info[:controller], '--port', info[:port], '--device', info[:device], '--type', 'hdd', '--medium', info[:d1]]
        vb.customize ['storageattach', :id, '--storagectl', info[:controller], '--port', info[:port], '--device', info[:device],'--type', 'hdd', '--medium', info[:d1]]
#
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
