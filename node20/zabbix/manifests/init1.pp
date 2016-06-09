class zabbix::init1
{

file {'/tmp/zabbix-agent.tar.gz':
ensure => 'file',
source => 'puppet:///modules/zabbix/zabbix-agent.tar.gz',
}

exec { 'extract':
require => File["/tmp/zabbix-agent.tar.gz"],
path => ["/usr/bin/", "/usr/sbin/"],
cwd => '/tmp',
command => "tar -xzf zabbix-agent.tar.gz",
}

exec { 'installing':
require => Exec["extract"],
cwd => '/tmp/zabbix-agent/',
path => ["/usr/bin/", "/usr/sbin/"],
command => "yum --nogpgcheck localinstall -y *.rpm",
}

file {'/tmp/scripts.tar.gz':
require => Exec["installing"],
ensure => 'file',
source => 'puppet:///modules/zabbix/scripts.tar.gz',
}


exec { 'extractscripts':
require => File["/tmp/scripts.tar.gz"],
path => ["/usr/bin/", "/usr/sbin/"],
cwd => '/tmp/',
command => "tar -xzf scripts.tar.gz",

}

exec {'move-scripts':
require => Exec["extractscripts"],
path => ["/usr/bin/", "/usr/sbin/"],
cwd => '/tmp/',
command => "mv scripts /etc/zabbix/.",
}

file {'/etc/zabbix/zabbix_agentd.conf':
require => Exec["installing"],
ensure => 'present',
content => template("zabbix/zabbix_agentd.conf.erb"),
}

service {'zabbix-agent-start':
require => File["/etc/zabbix/zabbix_agentd.conf"],
start => 'service zabbix-agent start',
ensure => 'running',
}
}

