node default {
}

node 'elastic.psi.ch' {
  class { 'elk::install': }
}

node 'linux1.psi.ch' {
  class { 'metricbeat::install': }
}
