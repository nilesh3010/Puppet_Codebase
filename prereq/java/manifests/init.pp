class java{

require 'stdlib'
file { '/tmp/jdk-8u77-linux-x64.tar.gz':
source => "puppet:///modules/java/jdk-8u77-linux-x64.tar.gz",
owner => 'root',
}

exec { 'extract_java':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File['/tmp/jdk-8u77-linux-x64.tar.gz'],
cwd => "/tmp",
command => "tar -xzf jdk-8u77-linux-x64.tar.gz",
}

exec { 'set_java':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["extract_java"],
cwd => "/tmp",
command => "mv jdk1.8.0_77 /opt/",
}
exec { 'rm_java':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_java"],
cwd => "/usr/bin/",
command => "rm -rf java",
}
exec { 'rm_javac':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["rm_java"],
cwd => "/usr/bin/",
command => "rm -rf javac",
}

file_line { 'edit_bashrc':
require => Exec["rm_javac"],
path => '/root/.bashrc',
line => 'export JAVA_HOME=/opt/jdk1.8.0_77
export JRE_HOME=/opt/jdk1.8.0_77/jre
export PATH=$PATH:/opt/jdk1.8.0_77/bin:/opt/jdk1.8.0_77/jre/bin',
}

exec { 'set_links1':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_java"],
command => "ln -s /opt/jdk1.8.0_77/bin/java /usr/bin/java",
}

exec { 'set_links2':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_links1"],
command => "ln -s /opt/jdk1.8.0_77/bin/javac /usr/bin/javac",
}

exec { 'remove_dir':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_links2"],
cwd => "/tmp",
command => "rm -rf jdk1.8.0_77",
}
}

