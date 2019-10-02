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
  file { ["/etc/telegraf/telegraf.conf"]:
    notify => Service["telegraf"],
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => ['puppet:///modules/telegraf/telegraf.conf'],
  }
  file { ["/etc/telegraf/telegraf.d/cpu.conf"]:
    notify => Service["telegraf"],
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => ['puppet:///modules/telegraf/cpu.conf'],
  }
  file { ["/etc/telegraf/telegraf.d/disk.conf"]:
    notify => Service["telegraf"],
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => ['puppet:///modules/telegraf/disk.conf'],
  }
  file { ["/etc/telegraf/telegraf.d/diskio.conf"]:
    notify => Service["telegraf"],
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => ['puppet:///modules/telegraf/diskio.conf'],
  }
  file { ["/etc/telegraf/telegraf.d/mem.conf"]:
    notify => Service["telegraf"],
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => ['puppet:///modules/telegraf/mem.conf'],
  }
  file { ["/etc/telegraf/telegraf.d/net.conf"]:
    notify => Service["telegraf"],
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => ['puppet:///modules/telegraf/net.conf'],
  }
  file { ["/etc/telegraf/telegraf.d/system.conf"]:
    notify => Service["telegraf"],
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => ['puppet:///modules/telegraf/system.conf'],
  }
  file { ["/etc/telegraf/telegraf.d/netstat.conf"]:
    notify => Service["telegraf"],
    mode => "0644",
    owner => 'root',
    group => 'root',
    source => ['puppet:///modules/telegraf/netstat.conf'],
  }
}
