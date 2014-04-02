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
  package { ['php',
             'php-fpm',
             'php-apc',
             'php-gd',
             'php-intl',
             'php-imagick',
             'php-mcrypt',
             'php-memcache',
             'php-pspell',
             'php-sqlite',
             'php-tidy',
             'php-geoip',
             'php-xsl']:
    ensure => present;
  }
}

class php::service {
  service {'php-fpm':
    ensure => running,
    enable => true,
    hasrestart => true,
    restart => 'systemctl reload php-fpm'
  }
}

class php::configure {
  $php_fpm = '/etc/php/php-fpm.conf'
  $php_ini = '/etc/php/php.ini'

  set_property { 'php-date-timezone':
    property => "date.timezone",
    value => "Europe\\/Amsterdam",
  }
  set_property { 'php-short_open_tag':
    property => "short_open_tag",
    value => "Off",
  }
}

class php {
  include php::install
  include php::configure
  include php::service
}
