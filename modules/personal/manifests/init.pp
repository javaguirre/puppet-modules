class personal {
  package{ ["zsh", "vim", "tmux", "stow", "git"]:
    ensure => "installed"
  }

  user { "vagrant":
    ensure => "present",
    shell => '/usr/bin/zsh'
  }

  exec { 'dotfiles':
    command => 'git clone https://github.com/javaguirre/dotfiles',
    cwd => '/home/vagrant',
    user => 'vagrant',
    group => 'users',
    creates => '/home/vagrant/dotfiles'
  }

  exec { 'vim-install':
    command => 'git clone https://github.com/gmarik/vundle.git /home/vagrant/.vim/bundle/vundle',
    cwd => '/home/vagrant',
    user => 'vagrant',
    group => 'users',
    creates => '/home/vagrant/.vim/bundle/vundle'
  }

  # exec { 'vim':
  #   command => 'vim +BundleInstall +qall',
  #   cwd => '/home/vagrant',
  #   user => 'vagrant',
  #   group => 'users',
  #   require => Exec['vim-install']
  # }

  exec { 'stow':
    command => 'stow vim && stow zsh && stow git && stow tmux && stow bash',
    cwd => '/home/vagrant/dotfiles',
    user => 'vagrant',
    group => 'users',
  }

  exec { 'oh-my-zsh':
    command => 'git clone https://github.com/javaguirre/oh-my-zsh.git /home/vagrant/.oh-my-zsh',
    cwd => '/home/vagrant',
    user => 'vagrant',
    group => 'users',
    creates => '/home/vagrant/.oh-my-zsh'
  }

  file { "/home/vagrant/.ssh/config":
    source => "puppet:///modules/personal/config",
    path => "/home/vagrant/.ssh/config",
    group => "users",
    owner => "vagrant"
  }
}
