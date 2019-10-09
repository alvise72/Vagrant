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
# CONFIGURE PATHS
#
class elk::configurepaths (
  String $baseelkdir = "/elk"
)
{
  file { '/etc/elasticsearch/elasticsearch.yml':
    ensure  => file,
    owner  => 'root',
    group  => 'elasticsearch',
    mode   => '0660',
    content => "path.data: $baseelkdir/lib\npath.logs: $baseelkdir/log",
  }
}

#
#
#
class elk::createpaths (
  String $baseelkdir = "/elk"
)
{
  exec { "Create ${baseelkdir}":
    creates => $baseelkdir,
    command => "mkdir -p ${baseelkdir}",
    path => $::path
  } -> file { $baseelkdir : }
  file { "${baseelkdir}/lib":
    ensure => directory,
    owner => 'root',
    group => 'elasticsearch',
    mode => '770',
    recurse =>true,
  }
  file { "${baseelkdir}/log":
    ensure => directory,
    owner => 'root',
    group => 'elasticsearch',
    mode => '770',
    recurse =>true,
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
