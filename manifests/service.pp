# == Class postfix::service
#
# This class is meant to be called from ::postfix.
# It ensures the service is running
#
class postfix::service {

  if $caller_module_name != $module_name {
    fail("This class is private and cannot be called from ${caller_module_name}.")
  }

  service { $::postfix::service_name:
    ensure     => $::postfix::service_ensure,
    enable     => $::postfix::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
