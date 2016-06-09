class nag::config{

file {'/etc/xinetd.d/nrpe':
ensure => 'present',
content => template("nag/nrpe.erb"),
}

exec {'serverdir':
#ensure => 'directory',
path => ["/usr/bin/", "/usr/sbin/"],
cwd => "/usr/local/nagios/etc/",
command => "mkdir servers",
}
file {'/usr/local/nagios/etc/nagios.cfg':
ensure => 'present',
content => template("nag/nagios.cfg.erb"),
}
file {'/usr/local/nagios/etc/objects/commands.cfg':
ensure => 'present',
content => template("nag/commands.cfg.erb"),
}

file { '/tmp/pw.sh':
require => Service["nagios"],
ensure => 'file',
source => 'puppet:///modules/nagios/pw.sh',
mode => '0755',
}

exec {"run-script":
require => File["/tmp/pw.sh"],
path => ["/usr/bin/", "/usr/sbin/" , "/bin/bash/", "/bin/", "/usr/local/bin/"],
command => "/tmp/pw.sh",
}

service {'xinetd':
require => File['/etc/xinetd.d/nrpe'],
start => "service xinetd start",
ensure => 'running',
}

service {'nagios':
#require => File['/usr/local/nagios/etc/objects/commands.cfg'],
start => "service nagios start",
ensure => 'running',
}

service {'httpd':
start => "service httpd restart",
ensure => 'running',
}

}
