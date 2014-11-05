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
  $package_name = $::postfix::params::package_name,
  $service_name = $::postfix::params::service_name,
) inherits ::postfix::params {

  # validate parameters here

  class { '::postfix::install': } ->
  class { '::postfix::config': } ~>
  class { '::postfix::service': } ->
  Class['::postfix']
}
