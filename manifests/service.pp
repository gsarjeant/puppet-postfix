# == Class postfix::service
#
# This class is meant to be called from postfix
# It ensure the service is running
#
class postfix::service {

  service { $::postfix::service_name:
    ensure     => $::postfix::service_ensure,
    enable     => $::postfix::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
