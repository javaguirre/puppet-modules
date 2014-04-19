class python::install {
  package { ["virtualenvwrapper"]:
    ensure => present;
  }
}
