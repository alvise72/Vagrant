class influxdb {
  yumrepo { "influx":
     baseurl => "https://repos.influxdata.com/rhel/7/x86_64/stable/",
     descr => "InfluxDB",
     enabled => 1,
     gpgcheck => 1,
     gpgkey => "https://repos.influxdata.com/influxdb.key"
  }  
  package { 'influxdb':
     ensure => present,
  }
  service { "influxdb":
    ensure => running,
    enable => true,
  }
}
