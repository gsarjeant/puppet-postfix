# == Class postfix::service
#
# This class is meant to be called from postfix
# It ensure the service is running
#
class postfix::service {

  service { $::postfix::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
