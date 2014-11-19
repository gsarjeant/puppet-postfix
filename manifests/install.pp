# == Class postfix::install
#
# This class is called from ::postfix to perform package install.
#
class postfix::install {

  if $caller_module_name != $module_name {
    fail("This class is private and cannot be called from ${caller_module_name}.")
  }
  package { $::postfix::package_name: ensure => $::postfix::package_ensure, }
}
