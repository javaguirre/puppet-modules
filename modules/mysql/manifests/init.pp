class mysql {
  case $::operatingsystem {
    Ubuntu: {
      $server_package = 'mysql-server'
      $client_package = 'mysql-client'
      $service_name = 'mysql'
    }
    default: {
      $server_package = 'mariadb'
      $client_package = 'mariadb-clients'
      $service_name = 'mysqld'
    }
  }

  package {[$server_package, $client_package]:
    ensure => present;
  }

  service { $service_name:
    ensure => running,
    enable => true,
    hasrestart => true,
    # restart => 'service restart mysqld',
    require => Package[$server_package]
  }
}
