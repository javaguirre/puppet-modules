class nginx {
  package { ['nginx']:
    ensure => present;
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    hasrestart => true,
    restart => 'systemctl reload nginx',
    require => Package['nginx']
  }
}

