node default {
}

node 'linux1.psi.ch' {
  class { 'gpfs::installrepo': }
  class { 'gpfs::installrpms': }
}

node 'linux2.home' {
}
