class metricbeat::install (
        String $version = "7.x",
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


  service { "metricbeat":
    ensure => running,
    enable => true,
    require => Package['metricbeat'],
  }
}
