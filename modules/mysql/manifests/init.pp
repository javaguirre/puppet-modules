class mysql {
  package {['mariadb', 'mariadb-clients']:
    ensure => present;
  }

  service { 'mysqld':
    ensure => running,
    enable => true,
    hasrestart => true,
    restart => 'systemctl restart mysqld',
    require => Package['mariadb']
  }
}
