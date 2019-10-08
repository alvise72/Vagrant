class mariadb {
  notify { 'Will install MariaDB...': }
  package { mariadb-server:
     ensure => present,
  }
  package { mariadb:
     ensure => present,
  }
}
