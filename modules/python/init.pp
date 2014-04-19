class python::install {
  package { ["python-virtualenv", "python2-virtualenv"]:
    ensure => "installed",
  }
}

class python {
  include python::install
}
