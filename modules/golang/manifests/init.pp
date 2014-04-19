class golang::install {
  # TODO Define GOROOT and GOPATH in .profile
  package { ["go"]:
    ensure => "installed",
  }

  #FIXME Example
  exec { "go get github.com/go-martini/martini":
    command => "go get github.com/go-martini/martini"
  }
}

class golang {
  include golang::install
}
