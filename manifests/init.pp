# == Class: postfix
#
# Basic setup of the postfix MTA.
#
# === Parameters
#
# [*relayhost*]
#   Set the relayhost in main.cf.
#
# [*myorigin*]
#   Set the value of postfix's myorigin config setting.
#
# [*package_name*]
#   Allow override of package name (default:postfix).
#
# [*package_ensure*]
#   Allow override of package ensure value (default: installed).
#
# [*service_name*]
#   Allow override of service name (default:postfix).
#
# [*service_ensure*]
#   Allow override of service ensure (default: running).
#
# [*service_enable*]
#   Allow override of service enable (default: true).
#
class postfix (

  $relayhost = undef,
  $myorigin = undef,
  $package_name = $::postfix::params::package_name,
  $package_ensure = $::postfix::params::package_ensure,
  $service_name = $::postfix::params::service_name,
  $service_ensure = $::postfix::params::service_ensure,
  $service_enable = $::postfix::params::service_enable,

) inherits ::postfix::params {

  multi_validate_re($package_name, $service_name, $service_ensure, '^.+$')
  if $relayhost { validate_re($relayhost, '^.+$') }
  if $package_ensure { validate_re($package_ensure, '^.+$') }
  if $myorigin { validate_re($myorigin, '^.+$') }
  validate_bool($service_enable)

  class { '::postfix::install': } ->
  class { '::postfix::config': } ~>
  class { '::postfix::service': } ->
  Class['::postfix']
}
