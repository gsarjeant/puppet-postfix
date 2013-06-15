class postfix::params {
  case $::osfamily {
    'debian': {
      $package = 'postfix'
      $service = 'postfix'
    }
    default: {fail("OS family ${::osamily} not supported!")}
  }
}
