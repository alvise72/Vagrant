class metricbeat::install (
        String $version = "7.x",
        String $elkhost = "elastic.psi.ch",
        String $elkport = "9200",
        String $kibanahost = "elastic.psi.ch",
        String $kibanaport = "5601",
)
{
  yumrepo { "elk":
     baseurl => "https://artifacts.elastic.co/packages/7.x/yum",
     descr => "ElasticSearch $version",
     enabled => 1,
     gpgcheck => 1,
     gpgkey => "https://artifacts.elastic.co/GPG-KEY-elasticsearch",
     before => Package['metricbeat'],
  }


#-------------------------------------------------------------


  package { 'metricbeat':
     ensure => present,
     require => Yumrepo['elk'],
  }


#-------------------------------------------------------------

  file { '/etc/metricbeat/metricbeat.yml':
    ensure   => file,
    content  => template('metricbeat/metricbeat.yml.erb'),
    require => Package['metricbeat'],
    notify   => Service['metricbeat']
  }


#-------------------------------------------------------------


  service { "metricbeat":
    ensure  => running,
    enable  => true,
    require => File['/etc/metricbeat/metricbeat.yml'],
  }


#-------------------------------------------------------------


  exec { 'setupdashboard':
    command => "/bin/metricbeat setup dashboard",
    require => Service['metricbeat'],
  }

}
