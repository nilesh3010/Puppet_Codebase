class jenkins {

require 'users::create_jenkins'

file{'/tmp/jenkins-1.656-1.1.noarch.rpm':
source => 'puppet:///modules/jenkins/jenkins-1.656-1.1.noarch.rpm',
ensure => 'present',
}

exec{'jenkins-1.656-1.1.noarch.rpm':
path => ['/usr/bin','/usr/sbin'],
command => 'rpm -ivh /tmp/jenkins-1.656-1.1.noarch.rpm',
}

file{'/etc/sysconfig/jenkins':
ensure => 'file',
content => template("jenkins/jenkins.erb"),
}

exec{'delete':
path => ['/usr/bin','/usr/sbin'],
command => 'rm -rf /tmp/jenkins-1.656-1.1.noarch.rpm',
}

service{'jenkins':
start => 'service jenkins start',
ensure => 'running',
}


}
