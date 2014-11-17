# == Class: postfix
#
# Full description of class postfix here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class postfix (

  $relayhost = undef,
  $package_name = $::postfix::params::package_name,
  $package_ensure = $::postfix::params::package_ensure,
  $service_name = $::postfix::params::service_name,
  $service_ensure = $::postfix::params::service_ensure,
  $service_enable = $::postfix::params::service_enable,

) inherits ::postfix::params {

  if $relayhost { validate_re($relayhost, '^.+$') }
  multi_validate_re($package_name, $service_name, $service_ensure, '^.+$')
  if $package_ensure { validate_re($package_ensure, '^.+$') }
  validate_bool($service_enable)

  class { '::postfix::install': } ->
  class { '::postfix::config': } ~>
  class { '::postfix::service': } ->
  Class['::postfix']
}
