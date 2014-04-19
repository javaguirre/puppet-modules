define set_extension ($extension, $file = '/etc/php/php.ini') {
  exec { "php-set-${extension}":
      command => "sed -i \'s/^;extension=${extension}.so/extension=${extension}.so/g\' ${file}",
  }
}

define set_property ($property, $value, $file = '/etc/php/php.ini') {
  exec { "php-set-${property}":
      command => "sed -i \"s/^[; ]*${property} =.*/${property} = ${value}/g\" ${file}",
  }
}

class php::install {
  case $::operatingsystem {
    Ubuntu: {
      $php_package = 'php5'
    }
    default: {
      $php_package = 'php'
    }
  }

  package { ["$php_package",
             "$php_package-fpm",
             "$php_package-gd",
             "$php_package-intl",
             # "$php_package-apc",
             # "$php_package-imagick",
             "$php_package-mcrypt",
             "$php_package-memcache",
             "$php_package-pspell",
             "$php_package-sqlite",
             "$php_package-tidy",
             "$php_package-geoip",
             "$php_package-curl",
             "$php_package-xsl"]:
    ensure => present;
  }
}

class php::service {
  service {'php-fpm':
    ensure => running,
    enable => true,
    hasrestart => true,
    # restart => 'systemctl reload php-fpm'
  }
}

class php::configure {
  case $::operatingsystem {
    Ubuntu: {
      $php_fpm = '/etc/php5/php-fpm.conf'
      $php_ini = '/etc/php5/cli/php.ini'
    }
    default: {
      $php_fpm = '/etc/php/php-fpm.conf'
      $php_ini = '/etc/php/php.ini'
    }
  }

  set_property { 'php-date-timezone':
    property => "date.timezone",
    value => "Europe\\/Amsterdam",
    file => $php_ini
  }
  set_property { 'php-short_open_tag':
    property => "short_open_tag",
    value => "Off",
    file => $php_ini
  }
}

class php {
  include php::install
  include php::configure
  # include php::service
}
