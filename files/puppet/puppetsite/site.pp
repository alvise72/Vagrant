node default {
}

node 'elk.psi.ch' {
  class { 'elk::installrepo': }
  class { 'elk::installrpms': }
  class { 'elk::configurepaths': }
  class { 'elk::startservices': }
  include ::lvm
}
