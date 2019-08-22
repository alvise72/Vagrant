# VBoxManage list hdds
# fastest way is to change the path of attached disk

VAGRANTFILE_API_VERSION = "2"

require 'getoptlong'

opts = GetoptLong.new(
  [ '--storage-path', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--memory', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--cores', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--disk-size', GetoptLong::OPTIONAL_ARGUMENT ]
)

storage='/Volumes/RD_Storage'
memory=14336
cores=2
disksize=100

opts.each do |opt, arg|
  case opt
    when '--storage-path'
      storage=arg
    when '--memory'
      memory=arg
    when '--cores'
      cores=arg
    when '--disk-size'
      disksize=arg
  end
end

cluster = {

  "linux1" => { :box => "centos/7",
                :ip_pri => "192.168.1.101",
                :ip_pub => "10.0.1.101",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx1-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => '#{storage}/disk-lnx1-2.vdi', :dsize2 => '#{disksize}',
              } ,
  "linux2" => { :box => "centos/7",
                :ip_pri => "192.168.1.102",
                :ip_pub => "10.0.1.102",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx2-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => "#{storage}/disk-lnx2-2.vdi", :dsize2 => '#{disksize}',
              }	 ,    
  "linux3" => { :box => "centos/7",
                :ip_pri => "192.168.1.103",
                :ip_pub => "10.0.1.103",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx3-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => '#{storage}/disk-lnx3-2.vdi', :dsize2 => '#{disksize}',
              }	 ,	       
  "linux4" => { :box => "centos/7",
                :ip_pri => "192.168.1.104",
                :ip_pub => "10.0.1.104",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx4-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => '#{storage}/disk-lnx4-2.vdi', :dsize2 => '#{disksize}',
              }	 ,
  "linux5" => { :box => "centos/7",
                :ip_pri => "192.168.1.105",
                :ip_pub => "10.0.1.105",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx5-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => '#{storage}/disk-lnx5-2.vdi', :dsize2 => '#{disksize}',
              }	 ,
  "linux6" => { :box => "centos/7",
                :ip_pri => "192.168.1.106",
                :ip_pub => "10.0.1.106",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx6-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => '#{storage}/disk-lnx6-2.vdi', :dsize2 => '#{disksize}',
              }	 ,
  "linux7" => { :box => "centos/7",
                :ip_pri => "192.168.1.107",
                :ip_pub => "10.0.1.107",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx7-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => '#{storage}/disk-lnx7-2.vdi', :dsize2 => '#{disksize}',
              }	 ,
  "linux8" => { :box => "centos/7",
                :ip_pri => "192.168.1.108",
                :ip_pub => "10.0.r.108",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx8-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => '#{storage}/disk-lnx8-2.vdi', :dsize2 => '#{disksize}',
              }	 ,
  "linux9" => { :box => "centos/7",
                :ip_pri => "192.168.1.109",
                :ip_pub => "10.0.1.109",
                :cpus => '#{cores}',
                :mem => '#{memory}',
                :d1 => '#{storage}/disk-lnx9-1.vdi', :dsize1 => '#{disksize}'
                #:d2 => '#{storage}/disk-lnx9-2.vdi', :dsize2 => '#{disksize}',
              }
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
        if not File.exists?(info[:d1])
          vb.customize ['createhd', '--filename', info[:d1],  '--size', info[:dsize1] * 1024]
        end
#        if not File.exists?(info[:d2])
#          vb.customize ['createhd', '--filename', info[:d2],  '--size', info[:dsize2] * 1024]
#        end
#	if not File.exists?(info[:d3])
#          vb.customize ['createhd', '--filename', info[:d3],  '--size', info[:dsize3] * 1024]
#        end
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
	vb.customize ["storagectl", :id, "--name", "SATA Controller", "--add", "sata"]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 0, '--device', 0, '--type', 'hdd', '--medium', info[:d1]]
#        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', info[:d2]]
#	vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', info[:d3]]
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
      end # end cfg.vm.provider
      cfg.vm.box = "#{info[:box]}"
      #cfg.ssh.username = 'root'
      #cfg.ssh.password = 'vagrant'
      #cfg.ssh.insert_key = 'true'
      cfg.ssh.forward_agent = true
      cfg.ssh.forward_x11 = true
      config.ssh.keep_alive = true
#      cfg.ssh.insert_key = false
#      cfg.vm.provision "shell", inline: 'sudo /vagrant/copy-init.sh'
##      cfg.vm.provision "file", source: "cluster-init.sh", destination: "/root/cluster-init.sh"
      #    end # end config

      config.vm.provision "shell", path: "scripts/setup.sh"
#      config.vm.provision "shell", inline: <<-SHELL
#        #sudo mkfs.ext4 /dev/sdb
#        #sudo mkfs.ext4 /dev/sdc
#        #sudo mkfs.ext4 /dev/sdd
#        yum -y update
#        yum -y install lvm2 gcc-c++ make cmake net-tools sysstat dstat
#	#cp /vagrant/repos/gpfs* /etc/yum.repos.d
#	#yum clean all
#	#yum install -y gpfs.msg.en_US gpfs.gskit gpfs.base gpfs.gpl gpfs.docs
#	
# 
#        SHELL
    end
  end # end cluster loop

end # end configure
