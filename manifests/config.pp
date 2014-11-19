# == Class postfix::config
#
# This class is called from ::postfix to perform config.
#
class postfix::config {

  unless $caller_module_name == $module_name {
    fail("This class is private and cannot be called from ${caller_module_name}.")
  }

  $relayhost = $::postfix::relayhost

  if $relayhost {
    validate_re($relayhost, '^.+$')
    ini_setting { 'Postfix relayhost setting':
      ensure  => present,
      path    => $::postfix::params::config,
      section => '',
      setting => 'relayhost',
      value   => $relayhost,
    }
  }

}
