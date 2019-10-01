class gpfs_repo {
yumrepo { "gpfs":
     baseurl => "https://linux.web.psi.ch/ext/gpfs/5.0.3-2/gpfs_rpms",
     descr => "GPFS 5.0.3-2",
     enabled => 1,
     gpgcheck => 0,
}
}
