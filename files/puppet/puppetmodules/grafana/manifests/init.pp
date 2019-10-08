class grafana {
  yumrepo { "grafana":
     baseurl => "https://packages.grafana.com/oss/rpm",
     descr => "Grafana",
     enabled => 1,
     gpgcheck => 1,
     gpgkey => "https://packages.grafana.com/gpg.key"
  }  
  package { 'grafana':
     ensure => present,
  }
  package { 'fontconfig':
     ensure => present,
  }
  package { 'freetype*':
     ensure => present,
  }
  package { 'urw-fonts':
     ensure => present,
  }
  service { "grafana-server":
    ensure => running,
    enable => true,
  }
}
