# == Class postfix::params
#
# This class is meant to be called from postfix
# It sets variables according to platform
#
class postfix::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'postfix'
      $service_name = 'postfix'
    }
    'RedHat', 'Amazon': {
      $package_name = 'postfix'
      $service_name = 'postfix'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
