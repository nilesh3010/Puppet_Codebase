class sonarrunner
{
file{'/opt/software/sonar-runner-dist-2.4.zip':
ensure => 'present',
source => 'puppet:///modules/sonarrunner/sonar-runner-dist-2.4.zip',
}
exec {'unzip':
require => file['/opt/software/sonar-runner-dist-2.4.zip'],
cwd => '/opt/software/',
command => '/usr/bin/unzip sonar-runner-dist-2.4.zip -d /opt/software/',
}
file{'/opt/software/sonar-runner-2.4/conf/sonar-runner.properties':
require => exec['unzip'],
content => template("sonarrunner/sonar-runner.properties.erb"),
}
}
