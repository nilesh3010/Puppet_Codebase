class jfrog {
#require 'users::create_jfrog'
#require 'unzip::install'
#require 'maven::install'
/*
file { '/tmp/jfrog-artifactory-oss-4.7.7.zip':
source => "puppet:///modules/jfrog/jfrog-artifactory-oss-4.7.7.zip",
owner => 'root',
}

exec { 'extract_jfrog':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => File['/tmp/jfrog-artifactory-oss-4.7.7.zip'],
cwd => "/tmp/",
command => "unzip jfrog-artifactory-oss-4.7.7.zip",
}

exec { 'make_dirr':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
cwd => "/opt/",
require => Exec["extract_jfrog"],
command => "mkdir jfrog",
}

exec { 'move_dirr':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
cwd => "/tmp/",
command => "mv artifactory-oss-4.7.7 /opt/jfrog/",
require => Exec["make_dirr"],
}

file_line{'edit_conf':
path => '/opt/jfrog/artifactory-oss-4.7.7/bin/artifactory.default',
require => Exec["move_dirr"],
line => 'export ARTIFACTORY_HOME=/opt/jfrog/artifactory-oss-4.7.7
export ARTIFACTORY_USER=jfrog
export JAVA_HOME=/opt/jdk1.8.0_77'
}

exec { 'ownershipp':
path    => ["/usr/bin/", "/usr/sbin/", "/bin/"],
require => File_line["edit_conf"],
command => "chown -R jfrog. /opt/jfrog",
}

exec { 'run_artifactory':
path => ["/usr/bin/","/usr/sbin/"],
require => Exec["ownershipp"],
command => "runuser -l jfrog -c '/opt/jfrog/artifactory-oss-4.7.7/bin/artifactoryctl start'",
}

file_line{'max_allowed_packet':
path => '/etc/my.cnf',
line => 'max_allowed_packet=8M',
ensure => "present",
}*/
file_line{'innodb_buffer_pool_size':
path => '/etc/my.cnf',
line => 'innodb_buffer_pool_size=1536M',
ensure => "present",
}
file_line{'tmp_table_size':
path => '/etc/my.cnf',
line => 'tmp_table_size=512M',
ensure => "present",
}
file_line{'max_heap_table_size':
path => '/etc/my.cnf',
line => 'max_heap_table_size=512M',
ensure => "present",
}
file_line{'innodb_log_file_size':
path => '/etc/my.cnf',
line => 'innodb_log_file_size=256M',
ensure => "present",
}
file_line{'innodb_log_buffer_size':
path => '/etc/my.cnf',
line => 'innodb_log_buffer_size=4M',
ensure => "present",
}
exec{'storage_properties':
cwd=>'/opt/jfrog/artifactory-oss-4.7.7/misc/db/',
command => 'cp -rf /opt/jfrog/artifactory-oss-4.7.7/misc/db/mysql.properties /opt/jfrog/artifactory-oss-4.7.7/etc/storage.properties',
require => exec["run_artifactory"],
}
file{'/opt/jfrog/artifactory-oss-4.7.7/tomcat/lib/mysql-connector-java-5.1.4.jar':
source =>"puppet:///modules/jfrog/mysql-connector-java-5.1.4.jar",
}
}
