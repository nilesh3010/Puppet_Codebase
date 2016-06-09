class zabbixdependency
{
#require 'mysql'

file {'/tmp/myrpm.tar.gz':
ensure => 'file',
source => 'puppet:///modules/zabbixdependency/myrpm.tar.gz',
}

exec {'extract-myrpm':
path => ["/usr/bin/" , "/usr/sbin/" ],
cwd => "/tmp/",
require => File["/tmp/myrpm.tar.gz"],
command => 'tar -xzf myrpm.tar.gz',
}


exec {'zabbixdependency':
path => ["/usr/bin/" , "/usr/sbin/" ],
cwd => "/tmp/myrpm/",
require => Exec["extract-myrpm"],
command => "yum --nogpgcheck localinstall -y *.rpm",
}

}
