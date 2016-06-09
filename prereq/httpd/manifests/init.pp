class httpd
{
file { '/tmp/httpdrpms.tar.gz':
ensure =>'present',
source => 'puppet:///modules/httpd/httpdrpms.tar.gz',
}

exec{'unzip':
require => File['/tmp/httpdrpms.tar.gz'],
path => ['/usr/bin','/usr/sbin'],
cwd => '/tmp',
command => 'tar -zxf httpdrpms.tar.gz',
}

exec{'httpdrpminstalling':
require => Exec['unzip'],
path => ['/usr/bin','/usr/sbin'],
cwd => '/tmp/httpdrpms/',
command => 'yum --nogpgcheck localinstall -y *.rpm',
#cwd => '/tmp/httpd-2.4.6-40.el7.centos.x86_64.rpm'
}
exec {'start':
require => Exec['httpdrpminstalling'],
command => '/bin/systemctl start  httpd.service',
}
}

