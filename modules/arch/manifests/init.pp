class arch {
  exec { 'pacman -Sy':
    command => '/usr/bin/pacman -Sy'
  }
}
