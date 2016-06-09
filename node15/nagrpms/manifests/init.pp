 class nagrpms {

file {'/tmp/rpm.tar.gz':
ensure => file,
source => 'puppet:///modules/nagrpms/rpm.tar.gz',
}

exec { 'untarrpm':
path => ["/usr/bin/" , "/usr/sbin/"],
require => File["/tmp/rpm.tar.gz"],
cwd => "/tmp/",
command => "tar -zxf rpm.tar.gz",
}

exec { 'installrpm':
path => ["/usr/bin/" , "/usr/sbin/"],
require => Exec["untarrpm"],
cwd => "/tmp/rpm/",
command => "yum localinstall -y nogpgcheck   *.rpm",
timeout => 1800,
}
}

