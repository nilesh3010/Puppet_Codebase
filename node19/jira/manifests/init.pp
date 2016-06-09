class jira {
require 'jira::db'
user {'jira':
ensure=>"present",
comment=>'jira user',
home=>'/home/jira',
shell=>'/bin/bash',
managehome=>'true',
}

file {['/opt/software/atlassian/','/opt/software/atlassian/jira/']:
ensure=>'directory',
owner=>'jira',
group=>'jira',
}

file{ '/opt/software/atlassian/jira/atlassian-jira-6.4.12.tar.gz':
ensure => "file",
source => "puppet:///modules/jira/atlassian-jira-6.4.12.tar.gz",
owner=>'jira',
group=>'jira',
 }
exec {'unzip':
require=> File['/opt/software/atlassian/jira/atlassian-jira-6.4.12.tar.gz'],
user=>'jira',
group=>'jira',
command=>'/usr/bin/tar -zxvf /opt/software/atlassian/jira/atlassian-jira-6.4.12.tar.gz',
cwd => '/opt/software/atlassian/jira/',
}

file { '/opt/software/atlassian/jira/atlassian-jira-6.4.12-standalone/atlassian-jira/WEB-INF/classes/jira-application.properties':
ensure=>"present",  
content=> template("jira/jira-application.properties.erb"),
  require=> Exec['unzip'],
}
/*
file {'/opt/software/atlassian/jira/atlassian-jira-6.4.12-standalone/conf/server.xml':
ensure=>"present",
content=> template("jira/server.xml.erb"),
require=> Exec['unzip'],
}
*/

file_line{'jira_port':
path => '/opt/software/atlassian/jira/atlassian-jira-6.4.12-standalone/conf/server.xml',
line => '<Connector port="8000"',
match => '<Connector port=".*$"',
ensure => "present",
require=> Exec['unzip'],
}

file {['/var/atlassian/','/var/atlassian/application-data/','/var/atlassian/application-data/jira/']:
ensure=>'directory',
owner=>'jira',
group=>'jira',
}

/*
exec {'start-jira.sh':
user=>'jira',
group=>'jira',
command=>'/opt/software/atlassian/jira/atlassian-jira-6.4.12-standalone/bin/start-jira.sh',
}
*/

}
