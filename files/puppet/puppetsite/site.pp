node default {
}

node 'linux1.psi.ch' {
  class { 'gpfs::installrepo': }
  class { 'gpfs::installrpms': }
}

node 'linux2.psi.ch' {
class { 'gpfs::installrepo': }
  class { 'gpfs::installrpms': }
include ::lvm
}

node 'linux3.psi.ch' {
class { 'gpfs::installrepo': }
  class { 'gpfs::installrpms': }
include ::lvm
}
node 'linux4.psi.ch' {
class { 'gpfs::installrepo': }
  class { 'gpfs::installrpms': }
include ::lvm
}
node 'linux5.psi.ch' {
class { 'gpfs::installrepo': }
  class { 'gpfs::installrpms': }
include ::lvm
}
