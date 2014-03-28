# Example of manifests/site.pp
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin/" ] }

stage { 'prepare': before => Stage['main'] }

class {
    'arch': stage => prepare;
    'personal': stage => main;
    'nginx': stage => main;
    'mysql': stage => main;
    'php': stage => main;
}
