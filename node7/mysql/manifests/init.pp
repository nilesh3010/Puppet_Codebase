class mysql{
file {"/tmp/mysql.tar.gz":
ensure => 'file',
source =>'puppet:///modules/mysql/mysql.tar.gz',
}
 

exec {"remove-postfix":
path => ["/usr/sbin/","/usr/bin/"],
command => "rpm -e postfix-2.10.1-6.el7.x86_64",
}


exec {"remove-maria":
path => ["/usr/sbin/","/usr/bin/"],
command => "rpm -e mariadb-libs-5.5.44-2.el7.centos.x86_64",
}

exec {"untar":
require => File["/tmp/mysql.tar.gz"],
path => ["/usr/sbin/","/usr/bin/"],
cwd =>'/tmp/',
command => "tar -xzf mysql.tar.gz",
}

exec {"installing":
require => Exec["untar"],
path => ["/usr/sbin/","/usr/bin/"],
cwd => '/tmp/mysql/',
command => "yum localinstall -y nogpgcheck *.rpm",
}

service {'mysqld':
require => Exec["installing"],
start => "service mysqld start",
ensure => 'running',
}

file {'/tmp/my.sh':
require => Service["mysqld"],
ensure => 'file',
source => 'puppet:///modules/mysql/my.sh',
mode => '0755',
}

exec {"script":
require => File["/tmp/my.sh"],
path => ["/usr/bin", "/usr/sbin/" , "/bin/bash/", "/bin/","/usr/local/bin/"],
command => "/tmp/my.sh",
}

}
