node default {
}

node 'elk.psi.ch' {
  class { 'elk::lvm': }
  class { 'elk::installrepo': }
  class { 'elk::installrpms': }
  class { 'elk::configurepaths': }
  class { 'elk::createpaths': }
  class { 'elk::startservices': }
}
