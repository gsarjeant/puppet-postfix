# == Class postfix::params
#
# This class is meant to be called from ::postfix.
# It sets variables according to platform.
#
class postfix::params {
  unless $caller_module_name == $module_name {
    fail("This class is private and cannot be called from ${caller_module_name}.")
  }

  case $::osfamily {
    'Debian','RedHat','Amazon': {}
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  $package_name = 'postfix'
  $package_ensure = 'installed'

  $config = '/etc/postfix/main.cf'

  $service_name = 'postfix'
  $service_ensure = 'running'
  $service_enable = true
}
