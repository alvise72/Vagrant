node default {
}

node 'elk.psi.ch' {
  class { 'elk::installrepo': }
  class { 'elk::installrpms': }
  class { 'elk::startservices': }
  include ::lvm
}
