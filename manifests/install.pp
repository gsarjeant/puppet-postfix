# == Class postfix::install
#
class postfix::install {
  package { $::postfix::package_name: ensure => $::postfix::package_ensure, }
}
