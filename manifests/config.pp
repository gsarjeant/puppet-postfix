# == Class postfix::config
#
# This class is called from ::postfix to perform config.
#
class postfix::config {

  if $caller_module_name != $module_name {
    fail("This class is private and cannot be called from ${caller_module_name}.")
  }

  $relayhost = $::postfix::relayhost
  $myorigin = $postfix::myorigin

  validate_absolute_path($::postfix::params::config)
  $config = $::postfix::params::config

  if $relayhost {
    validate_re($relayhost, '^.+$')
    file_line { 'relayhost setting':
      ensure  => present,
      path    => $config,
      line => "relayhost = ${relayhost}",
      match => "^relayhost\s*=\s*.*$",
    }
  }

  if $myorigin {
    validate_re($myorigin, '^.+$')
    file_line { 'myorigin setting':
      ensure  => present,
      path    => $config,
      line => "myorigin = ${myorigin}",
      match => "^myorigin\s*=\s*.*$",
    }
  }
}
