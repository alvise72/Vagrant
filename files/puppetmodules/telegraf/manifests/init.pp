class telegraf {
  yumrepo { "telegraf":
     baseurl => "https://repos.influxdata.com/rhel/7/x86_64/stable/",
     descr => "InfluxDB",
     enabled => 1,
     gpgcheck => 1,
     gpgkey => "https://repos.influxdata.com/influxdb.key"
  }  
  package { 'telegraf':
     ensure => present,
  }
  service { "telegraf":
    ensure => running,
    enable => true,
  }
  file { ["/etc/telegraf/telegraf.conf",
          "/etc/telegraf/telegraf.d/cpu.conf",
          "/etc/telegraf/telegraf.d/mem.conf",
          "/etc/telegraf/telegraf.d/disk.conf",
          "/etc/telegraf/telegraf.d/diskio.conf",
          "/etc/telegraf/telegraf.d/system.conf",
          "/etc/telegraf/telegraf.d/netstat.conf"]:
        notify => Service["telegraf"],
        mode => "0644",
        owner => 'root',
        group => 'root',
        source => ['puppet:///modules/telegraf/telegraf.conf',
                   'puppet:///modules/telegraf/cpu.conf',
                   'puppet:///modules/telegraf/mem.conf',
                   'puppet:///modules/telegraf/net.conf',
                   'puppet:///modules/telegraf/disk.conf',
                   'puppet:///modules/telegraf/diskio.conf',
                   'puppet:///modules/telegraf/system.conf',
                   'puppet:///modules/telegraf/netstat.conf'
                  ],
  }
}
