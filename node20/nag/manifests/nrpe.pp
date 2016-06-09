class nag::nrpe  {

require 'nag::nagios'
require 'nag::plugins'

file {'/tmp/nrpe-2.15.tar.gz':
ensure => present,
source => "puppet:///modules/nag/nrpe-2.15.tar.gz",
}

exec { 'extract_nrpe':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => File['/tmp/nrpe-2.15.tar.gz'],
cwd => "/tmp/",
command => "tar -zxvf nrpe-2.15.tar.gz",
}

exec { 'move_nrpe':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["extract_nrpe"],
cwd => "/tmp/",
command => "mv nrpe-2.15 /opt/",
}

exec { 'configure_nrpe':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["move_nrpe"],
cwd => "/opt/nrpe-2.15/",
command => "/opt/nrpe-2.15/configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu",
}

exec { 'install_nrpe1':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["configure_nrpe"],
cwd => "/opt/nrpe-2.15/",
command => "make all",
}




exec { 'install_nrpe2':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["install_nrpe1"],
cwd => "/opt/nrpe-2.15/",
command => "make install",
}

exec { 'install_nrpe3':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["install_nrpe2"],
cwd => "/opt/nrpe-2.15/",
command => "make install-xinetd",
}

exec { 'install_nrpe4':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["install_nrpe3"],
cwd => "/opt/nrpe-2.15/",
command => "make install-daemon-config",
}
}


