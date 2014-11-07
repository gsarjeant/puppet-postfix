# == Class postfix::params
#
# This class is meant to be called from postfix
# It sets variables according to platform
#
class postfix::params {
  case $::osfamily {
    'Debian': {
    }
    'RedHat', 'Amazon': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  $package_name = 'postfix'
  $package_ensure = 'installed'

  $config = '/etc/postfix/master.conf'

  $service_name = 'postfix'
  $service_ensure = 'running'
  $service_enable = true
}
