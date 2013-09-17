class postfix(
  $version = hiera('postfix::version', 'installed'),
  $relayhost = hiera('postfix::relayhost', '')
) inherits postfix::params {

  package { $package: ensure => $version, }

  File { owner => 'root', group => 'root', mode => '0644', }

  file { '/etc/mailname':
    ensure => file,
    content => "${::fqdn}",
  }

  file { $config:
    ensure => file,
    content => template("${module_name}/warning.erb",
      "${module_name}/main.cf.erb"),
    require => Package[$package],
  }

  service { $service:
    ensure => running,
    enable => true,
    subscribe => File[$config, '/etc/mailname'],
  }
}
