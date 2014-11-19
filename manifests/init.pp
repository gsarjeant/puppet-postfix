# == Class: postfix
#
# Basic setup of the postfix MTA.
#
# === Parameters
#
# [*relayhost*]
#   Set the relayhost in main.cf
#
# [*package_name*]
#   allow override of package name (default:postfix)
#
# [*package_ensure*]
#   allow override of package ensure value (default: installed)
#
# [*service_name*]
#   allow override of service name (default:postfix)
#
# [*service_ensure*]
#   allow override of service ensure (default: running)
#
# [*service_enable*]
#   allow override of service enable (default: true)
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
