class php

{
require 'httpd'
file {'/tmp/php-7.0.5.tar.gz':
ensure => 'file',
source => 'puppet:///modules/php/php-7.0.5.tar.gz',
}

file {'/tmp/extrarpms.tar.gz':
ensure => 'file',
source => 'puppet:///modules/php/extrarpms.tar.gz',
}

exec {'extrauntar':
require => File['/tmp/extrarpms.tar.gz'],
path => ["/usr/bin/" , "/usr/sbin/" , "/bin/"],
cwd => '/tmp/',
command => 'tar -xzf extrarpms.tar.gz',
}
exec {'extrainstalling':
require => Exec['extrauntar'],
path => ["/usr/bin/" , "/usr/sbin/" , "/bin/"],
cwd => '/tmp/extrarpms/',
command => "yum localinstall -y *.rpm",
}


exec{'untar':
require => File['/tmp/php-7.0.5.tar.gz'],
path => ["/usr/bin/" , "/usr/sbin/" , "/bin/"],
cwd => '/tmp/',
command => 'tar -xzf php-7.0.5.tar.gz',
}
exec{'copying':
require => Exec['untar'],
command => '/usr/bin/cp -r /tmp/php-7.0.5  /opt/php-7.0.5',
}
exec {'installing':
require => Exec['extrainstalling'],
path => ["/usr/bin/" , "/usr/sbin/" , "/bin/"],
cwd => '/opt/php-7.0.5/',
command => '/opt/php-7.0.5/buildconf --force',
}

exec {'configure':
path => ["/usr/bin/" , "/usr/sbin/" , "/bin/"],
require => Exec['installing'],
cwd => '/opt/php-7.0.5/',
command => '/opt/php-7.0.5/configure',
}
exec {'make':
require => Exec['configure'],
path => ["/usr/bin/" , "/usr/sbin/" , "/bin/"],
cwd => '/opt/php-7.0.5/',
timeout => '8000',
command => "make",
}
exec {'makeinstall':
require => Exec['make'],
path => ["/usr/bin/" , "/usr/sbin/" , "/bin/"],
cwd => '/opt/php-7.0.5/',
timeout => '8000',
command => "make install",
}
exec {'link':
require => Exec['makeinstall'],
path => ["/usr/bin/" , "/usr/sbin/" , "/bin/"],
command => 'ln -s /opt/php-7.0.5/sapi/cli/php /usr/bin/php',
}
}
