node default {
  class { 'gpfs::installrepo': }
  class { 'gpfs::installrpms': }
}

node 'linux1.psi.ch' {
}

node 'linux2.psi.ch' {
include ::lvm
}

node 'linux3.psi.ch' {
include ::lvm
}
node 'linux4.psi.ch' {
include ::lvm
}
node 'linux5.psi.ch' {
include ::lvm
}

