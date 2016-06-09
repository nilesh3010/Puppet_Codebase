class nag::nagios {
require 'nagrpms'
#include 'httpd'
#include 'php'
#include 'gcc'

file { '/tmp/nagios-4.1.1.tar.gz':
ensure => present,
source => "puppet:///modules/nag/nagios-4.1.1.tar.gz",
}

exec { 'extract_nagios':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File['/tmp/nagios-4.1.1.tar.gz'],
cwd => "/tmp/",
command => "tar -xzf nagios-4.1.1.tar.gz",
}

exec { 'move_nagios':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec ["extract_nagios"],
cwd => "/tmp/",
command => "mv  /tmp/nagios-4.1.1/ /opt/",
}

exec { 'configure_nagios':
path    => ["/opt/nagios-4.1.1", "/usr/sbin", "/bin"],
require => Exec ["move_nagios"],
cwd => "/opt/nagios-4.1.1/",
command => "./configure --with-command-group=nagcmd",
}




exec { 'install_nagios1':
path    => ["/opt/nagios-4.1.1", "/usr/sbin", "/bin"],
require => Exec ['configure_nagios'],
cwd => "/opt/nagios-4.1.1/",
command => "make all",
}



exec { 'install_nagios2':
path    => ["/opt/nagios-4.1.1", "/usr/sbin", "/bin"],
require => Exec ["install_nagios1"],
cwd => "/opt/nagios-4.1.1/",
command => "make install",
}


exec { 'install_nagios3':
path    => ["/opt/nagios-4.1.1", "/usr/sbin", "/bin"],
require => Exec ["install_nagios2"],
cwd => "/opt/nagios-4.1.1/",
command => "make install-commandmode",
}

exec { 'install_nagios4':
path    => ["/opt/nagios-4.1.1", "/usr/sbin", "/bin"],
require => Exec ["install_nagios3"],
cwd => "/opt/nagios-4.1.1/",
command => "make install-init",
}


exec { 'install_nagios5':
path    => ["/opt/nagios-4.1.1", "/usr/sbin", "/bin"],
require => Exec ["install_nagios4"],
cwd => "/opt/nagios-4.1.1/",
command => "make install-config",
}

exec { 'install_nagios6':
path    => ["/opt/nagios-4.1.1", "/usr/sbin", "/bin"],
require => Exec ["install_nagios5"],
cwd => "/opt/nagios-4.1.1/",
command => "make install-webconf",
}

}


