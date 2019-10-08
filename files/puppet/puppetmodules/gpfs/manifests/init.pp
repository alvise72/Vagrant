#
# INSTALL REPO
#
class gpfs::installrepo (
        String $version = "5.0.3-2"
)
{
  yumrepo { "gpfs":
     baseurl => "https://linux.web.psi.ch/ext/gpfs/$version/gpfs_rpms",
     descr => "GPFS $version",
     enabled => 1,
     gpgcheck => 0,
  }
  yumrepo { "zimon":
     baseurl => "https://linux.web.psi.ch/ext/gpfs/$version/zimon_rpms/rhel7",
     descr => "ZiMon $version",
     enabled => 1,
     gpgcheck => 0,
  }
}

#
# INSTALL RPMS
#
class gpfs::installrpms {
  package { 'gpfs.base':
     ensure => present,
  }
  package { 'gpfs.compression':
     ensure => present,
  }
  package { 'gpfs.docs':
     ensure => present,
  }
  package { 'gpfs.gpl':
     ensure => present,
  }
  package { 'gpfs.gskit':
     ensure => present,
  }
  package { 'gpfs.gss.pmcollector':
     ensure => present,
  }
  package { 'gpfs.gui':
     ensure => present,
  }
  package { 'gpfs.java':
     ensure => present,
  }
  package { 'gpfs.license.std':
     ensure => present,
  }
  package { 'gpfs.msg.en_US':
     ensure => present,
  }
}
