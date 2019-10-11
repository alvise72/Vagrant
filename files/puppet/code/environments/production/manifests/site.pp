node default {
}

node 'elk00.psi.ch' {
  class { 'elk::install': }
}

node 'linux1.psi.ch' {
  class { 'metricbeat::install': }
}
