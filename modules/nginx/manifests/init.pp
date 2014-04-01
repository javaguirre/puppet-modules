class nginx::install {
  package { ['nginx']:
    ensure => present;
  }
}

class nginx::service {
  service { 'nginx':
    ensure => running,
    enable => true,
    hasrestart => true,
    restart => 'systemctl reload nginx',
    require => Package['nginx']
  }
}

class nginx::configure {
  file { "/etc/nginx/sites":
    ensure => "directory"
  }

  file { "/etc/nginx/nginx.conf":
    source => "puppet:///modules/nginx/nginx.conf",
    require => Package['nginx'],
    notify => Service['nginx']
  }
}

class nginx {
  include nginx::install
  include nginx::configure
  include nginx::service
}
