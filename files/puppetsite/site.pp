node default {
}

node 'linux1.home' {
  class { 'influxdb': }
  class { 'telegraf': }
  class { 'grafana': }
}

node 'linux2.home' {
  class { 'telegraf': }
}

