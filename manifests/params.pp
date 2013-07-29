class postfix::params {
  case $::osfamily {
    'debian','redhat': {
      $package = 'postfix'
      $service = 'postfix'
    }
    default: {fail("OS family ${::osamily} not supported!")}
  }
}
