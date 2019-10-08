#
# INSTALL REPO
#
class elk::installrepo (
        String $version = "7.x"
)
{
  yumrepo { "elk":
     baseurl => "https://artifacts.elastic.co/packages/7.x/yum",
     descr => "ElasticSearch $version",
     enabled => 1,
     gpgcheck => 1,
     gpgkey => "https://artifacts.elastic.co/GPG-KEY-elasticsearch",
  }
}

#
# INSTALL RPMS
#
class elk::installrpms {
  package { 'elasticsearch':
     ensure => present,
  }
  package { 'kibana':
     ensure => present,
  }

}

#
# start/enable services
#
class elk::startservices {
  service { "elasticsearch":
    ensure => running,
    enable => true,
  }
  service { "kibana":
    ensure => running,
    enable => true,
  }
}
