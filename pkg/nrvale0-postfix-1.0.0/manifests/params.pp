class postfix::params {
  case $::osfamily {
    'debian','redhat': {
      $package = 'postfix'
      $config = '/etc/postfix/main.cf'
      $service = 'postfix'
    }
    default: {fail("OS family ${::osamily} not supported!")}
  }
}
