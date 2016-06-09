class gcc::install{

file { "/tmp/dependencies.tar.gz" :
ensure => "present",
source => "puppet:///modules/gcc/dependencies.tar.gz",
}

exec { 'extract_d':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File["/tmp/dependencies.tar.gz"],
cwd => "/tmp",
command => "tar -xzf dependencies.tar.gz",
}

exec { 'install_d':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
timeout =>'8000',
require => Exec["extract_d"],
cwd => "/tmp/dependencies",
command => "yum --nogpgcheck localinstall -y *.rpm",
}
}



