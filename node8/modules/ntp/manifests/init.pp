class ntp{

#require 'dependencies::install'
require 'gcc::install'

file { "/tmp/ntp-4.2.8p6.tar.gz" :
ensure => "present",
source => "puppet:///modules/ntp/ntp-4.2.8p6.tar.gz",
}

exec { 'extract_ntp':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File["/tmp/ntp-4.2.8p6.tar.gz"],
cwd => "/tmp",
command => "tar -xzf ntp-4.2.8p6.tar.gz",
}

exec{ 'move_ntp':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["extract_ntp"],
cwd => "/tmp",
command => "mv ntp-4.2.8p6 /opt/",
}

exec { 'install_ntp1':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["move_ntp"],
cwd => "/opt/ntp-4.2.8p6",
command => "/opt/ntp-4.2.8p6/configure",
}

exec { 'install_ntp2':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["install_ntp1"],
cwd => "/opt/ntp-4.2.8p6",
command => "make",
}

exec { 'install_ntp3':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["install_ntp2"],
cwd => "/opt/ntp-4.2.8p6",
command => "make install",
}


}



