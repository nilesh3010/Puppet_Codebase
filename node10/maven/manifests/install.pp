class maven::install($maven_archive="apache-maven-3.3.9-bin.tar.gz",
$maven_folder="apache-maven-3.3.9"){

#require 'users::create_jenkins'
#require 'java'

file { "/tmp/$maven_archive" :
ensure => "present",
source => "puppet:///modules/maven/$maven_archive",
}

exec { 'extract_maven':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File["/tmp/$maven_archive"],
cwd => "/tmp",
command => "tar -xzf $maven_archive",
}

exec { 'set_maven':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["extract_maven"],
cwd => "/tmp",
command => "mv -f $maven_folder /opt/",
}

file_line { 'edit_bash':
require => Exec["set_maven"],
path => '/root/.bashrc',
line => 'export M2_HOME=/opt/apache-maven-3.3.9
export PATH=$PATH:/opt/apache-maven-3.3.9/bin',
}

exec { 'set_links':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_maven"],
command => "ln -s /opt/$maven_folder/bin/mvn /usr/bin/mvn",
}

exec { 'remove_fold':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_links"],
cwd => "/tmp",
command => "rm -rf $maven_folder",
}

exec { 'remove_arch':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_links"],
cwd => "/tmp",
command => "rm -rf $maven_archive",
}

exec { 'owner':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["remove_arch"],
command => "chown -R jenkins. /usr/bin/mvn /opt/$maven_folder",
}

}
