class metricbeat::install (
        String $version = "7.x",
        String $elkhost = "elk.psi.ch",
        String $elkport = "9200",
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
    ensure  => file,
    content => template('conf/metricbeat.yml.erb'),
  }


#-------------------------------------------------------------


  service { "metricbeat":
    ensure => running,
    enable => true,
    require => File['/etc/metricbeat/metricbeat.yml'],
  }
}
