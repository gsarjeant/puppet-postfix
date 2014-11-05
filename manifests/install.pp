# == Class postfix::install
#
class postfix::install {

  package { $::postfix::package_name:
    ensure => present,
  }
}
