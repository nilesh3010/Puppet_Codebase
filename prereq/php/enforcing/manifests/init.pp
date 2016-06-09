class enforcing{

file {'/tmp/enforce.sh':
ensure => 'file',
source => 'puppet:///modules/enforcing/enforce.sh',
mode => '0755',
}

exec {"script":
require => File["/tmp/enforce.sh"],
path => ["/usr/bin", "/usr/sbin/" , "/bin/bash/", "/bin/","/usr/local/bin/"],
command => "/tmp/enforce.sh",
}
}
