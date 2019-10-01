class gpfsinstall {
  notify { 'Will install GPFS...': }
  package { 'gpfs.base':
     ensure => present,
  }
  package { 'gpfs.gpl':
     ensure => present,
  }
  package { 'gpfs.gskit':
     ensure => present,
  }
  package { 'gpfs.license.std':
     ensure => present,
  }
  package { 'gpfs.msg.en_US':
     ensure => present,
  }
}
