class nag::plugins{

require 'nag::nagios'


file{'/tmp/nagios-plugins-2.1.1.tar.gz':
ensure => present,
source => "puppet:///modules/nag/nagios-plugins-2.1.1.tar.gz",
}

exec { 'extract_nagios-plugins':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => File['/tmp/nagios-plugins-2.1.1.tar.gz'],
cwd => "/tmp/",
command => "tar -xzf nagios-plugins-2.1.1.tar.gz",
}

exec { 'move_nagios-plugins':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["extract_nagios-plugins"],
cwd => "/tmp/",
command => "mv nagios-plugins-2.1.1 /opt/",
}

exec { 'configure_nagios-plugins':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["move_nagios-plugins"],
cwd => "/opt/nagios-plugins-2.1.1/",
command => "/opt/nagios-plugins-2.1.1/configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl",
}
exec { 'make_nagios-plugins':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["configure_nagios-plugins"],
cwd => "/opt/nagios-plugins-2.1.1/",
command => "make",
}

exec { 'install_nagios-plugins':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => Exec ["make_nagios-plugins"],
cwd => "/opt/nagios-plugins-2.1.1/",
command => "make install",
}
}

