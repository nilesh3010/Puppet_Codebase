class sonarqube
{
file{'/opt/software/sonarqube-5.4.zip':
ensure => 'present',
source => 'puppet:///modules/sonarqube/sonarqube-5.4.zip',
}
exec {'unzipqube':
require => File['/opt/software/sonarqube-5.4.zip'],
cwd => '/opt/software/',
command => '/usr/bin/unzip sonarqube-5.4.zip -d /opt/software/',
}
file{'/opt/software/sonarqube-5.4/conf/sonar.properties':
require => Exec['unzipqube'],
content => template("sonarqube/sonar.properties.erb"),
}
#include 'sonarrunner'
exec{'starting':
require => File['/opt/software/sonarqube-5.4/conf/sonar.properties'],
command => '/opt/software/sonarqube-5.4/bin/linux-x86-64/sonar.sh start',
}
}
