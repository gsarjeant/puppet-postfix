# == Class postfix::config
#
# This class is called from postfix
#
class postfix::config {

  $relayhost = $::postfix::relayhost

  if $relayhost {
    ini_setting { 'Postfix relayhost setting':
      ensure => present,
      path => $::postfix::config,
      section => '',
      setting => 'relayhost',
      value => $relayhost,
    }
  }

}
