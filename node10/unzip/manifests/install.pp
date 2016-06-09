class unzip::install{

file { '/tmp/unzip-6.0-15.el7.x86_64.rpm':,
source => "puppet:///modules/unzip/unzip-6.0-15.el7.x86_64.rpm",
}

exec{ 'install_unzip':
path => ["/usr/bin","/usr/sbin"],
cwd => "/tmp",
require => File["/tmp/unzip-6.0-15.el7.x86_64.rpm"],
command => "rpm -i unzip-6.0-15.el7.x86_64.rpm",
}

exec{ 'delete_unzip':
path => ["/usr/bin","/usr/sbin"],
cwd => "/tmp",
require => Exec["install_unzip"],
command => "rm -f unzip-6.0-15.el7.x86_64.rpm",
}
}
