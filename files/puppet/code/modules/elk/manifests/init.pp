class elk::install (
        String $version = "7.x",
	String $elkdirname = "elk",
)
{
  yumrepo { "elk":
     baseurl => "https://artifacts.elastic.co/packages/7.x/yum",
     descr => "ElasticSearch $version",
     enabled => 1,
     gpgcheck => 1,
     gpgkey => "https://artifacts.elastic.co/GPG-KEY-elasticsearch",
     before => Package['elasticsearch'],
  }


#-------------------------------------------------------------


  package { 'elasticsearch':
     ensure => present,
     require => Yumrepo['elk'],
     before => Exec['createdir'],
  }
  package { 'kibana':
     ensure => present,
     require => Package['elasticsearch'],
  }


#-------------------------------------------------------------


  file { '/etc/elasticsearch/elasticsearch.yml':
    ensure  => file,
    owner  => 'root',
    group  => 'elasticsearch',
    mode   => '0660',
    content => "path.data: /${elkdirname}/elasticsearch/lib\npath.logs: /${elkdirname}/elasticsearch/log",
    require => Package['elasticsearch'],
  }


#-------------------------------------------------------------


  physical_volume { '/dev/sdb':
    ensure => present,
    before => Volume_group["vg_${elkdirname}"],
  }

  volume_group { "vg_${elkdirname}":
    ensure           => present,
    physical_volumes => '/dev/sdb',
    before           => Logical_volume["lv_${elkdirname}"],
  }

  logical_volume { "lv_${elkdirname}":
    ensure       => present,
    volume_group => "vg_${elkdirname}",
    size         => '99G',
    before       => Filesystem["/dev/vg_${elkdirname}/lv_${elkdirname}"],
  }

  filesystem { "/dev/vg_${elkdirname}/lv_${elkdirname}":
    ensure  => present,
    fs_type => 'xfs',
    before => Exec['createdir'],
  }

  file { "/${elkdirname}":
    ensure => directory,
    owner  => 'root',
    group  => 'elasticsearch',
    mode   => '770',
    before => Mount["/${elkdirname}"],
  }

  mount { "/${elkdirname}":
    ensure  => mounted,
    atboot  => true,
    device  => "/dev/vg_${elkdirname}/lv_${elkdirname}",
    fstype  => 'xfs',
    before  => Exec['createdir'],
    require => File["/${elkdirname}"],
  }

#  lvm::volume { "${elkdirname}":
#    ensure => present,
#    vg     => "${elkdirname}",
#    pv     => '/dev/sdb',
#    fstype => 'xfs',
#    size   => '99G',
#    before => Exec['createdir'],
#  }


#-------------------------------------------------------------

  exec { 'createdir':
    creates => "/$elkdirname",
    command => "mkdir -p /${elkdirname}/elasticsearch",
    path    => $::path,
    before  => Service['elasticsearch'],
    require => [ Mount["/${elkdirname}"], Package['elasticsearch'] ],
  } -> file { "/${elkdirname}/elasticsearch":
    ensure => directory,
    owner => 'root',
    group => 'elasticsearch',
    mode => '770',
    recurse =>true,
  }


#-------------------------------------------------------------


  service { "elasticsearch":
    ensure => running,
    enable => true,
    require => Exec['createdir'],
  }
  service { "kibana":
    ensure => running,
    enable => true,
    require => Service['elasticsearch']
  }
}
