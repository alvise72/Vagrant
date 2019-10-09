node default {
}

node 'elk.psi.ch' {
  include ::lvm
  class { 'elk::installrepo': }
  class { 'elk::installrpms': }
  class { 'elk::configurepaths': }
  class { 'elk::createpaths': }
  class { 'elk::startservices': }
}
