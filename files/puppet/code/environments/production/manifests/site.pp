node default {
}

node 'elk.psi.ch' {
  class { 'elk::install': }
}

node 'linux1.psi.ch' {
  class { 'metricbeat::install': }
}
