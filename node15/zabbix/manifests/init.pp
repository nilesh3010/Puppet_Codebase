class zabbix
{

require 'zabbix::zabbix'
require 'zabbixdependency' 
file {'/tmp/zabbix.tar.gz':
ensure => 'file',
source => 'puppet:///modules/zabbix/zabbix.tar.gz',
}

exec {'extract-tar':
path => ["/usr/bin/" , "/usr/sbin/" ],
cwd => "/tmp/",
require => File["/tmp/zabbix.tar.gz"],
command => 'tar -xzf zabbix.tar.gz',
}


exec {'zabbix':
path => ["/usr/bin/" , "/usr/sbin/" ],
cwd => "/tmp/zabbix/",
require => Exec["extract-tar"],
command => "yum --nogpgcheck localinstall -y *.rpm",
}

exec {'schema':
path => ["/usr/bin/" , "/usr/sbin/" ],
require => Exec["zabbix"],
command => "mysql -u zabbix -pAdmin@123 zabbixdb </usr/share/doc/zabbix-server-mysql-2.4.7/create/schema.sql",
}

exec {'images':
require => Exec["schema"],
path => ["/usr/bin/" , "/usr/sbin/" ],
command => "mysql -u zabbix -pAdmin@123 zabbixdb </usr/share/doc/zabbix-server-mysql-2.4.7/create/images.sql",
}

exec {'data':
require => Exec["images"],
path =>  ["/usr/bin/" , "/usr/sbin/" ],
command => "mysql -u zabbix -pAdmin@123 zabbixdb </usr/share/doc/zabbix-server-mysql-2.4.7/create/data.sql",
}

file {'/etc/php.ini':
ensure => 'present',
content => template("zabbix/php.ini.erb"),
}


file {'/etc/httpd/conf.d/zabbix.conf':
require => Exec["zabbix"],
ensure => 'present',
content => template("zabbix/zabbix.conf.erb"),
}

file {'/etc/zabbix/zabbix_server.conf':
require => File["/etc/httpd/conf.d/zabbix.conf"],
ensure => 'present',
content => template("zabbix/zabbix_server.conf.erb"),
}

file {'/etc/zabbix/web/zabbix.conf.php':
require => File["/etc/httpd/conf.d/zabbix.conf"],
ensure => 'present',
content => template("zabbix/zabbix.conf.php.erb"),
owner => "apache",
group => "apache",
}


service { 'agent-start':
require => File["/etc/zabbix/zabbix_server.conf"],
start => 'service zabbix-agent start',
ensure => 'running',
}
service { 'server-start':
require => File["/etc/zabbix/zabbix_server.conf"],
start => 'service zabbix-server start',
ensure => 'running',

}
service { 'httpd-restart':
require => File["/etc/zabbix/zabbix_server.conf"],
start => 'service httpd restart',
ensure => 'running',

}
/*
exec { 'chkconfig-agent':
path => ["/usr/bin/" , "/usr/sbin/" ],
command => 'chkconfig zabbix-agent on',
}
exec { 'chkconfig-server':
path => ["/usr/bin/" , "/usr/sbin/" ],
command => 'chkconfig zabbix-server on',
}*/
}



