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

  ini_setting { "telegraf influx target":
    ensure  => present,
    path    => '/etc/telegraf/telegraf.conf',
    section => '[outputs.influxdb]',
    setting => 'urls',
    value   => '["http://linux1-adm:8086"]',
  }
}
