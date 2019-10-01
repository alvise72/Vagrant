node default {
#  class { 'mariadb': }
#  class { 'gpfs_repo': }
#  class { 'gpfsinstall': }
#  class { 'influxdb': }
  class { 'telegraf': }
#  class { 'grafana': }
 }
