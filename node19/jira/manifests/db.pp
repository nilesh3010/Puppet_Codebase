class jira::db
{
        exec { "create":
command => "/usr/bin/mysql -uroot -pAdmin@123 -e \"create database jiradb CHARACTER SET utf8 COLLATE utf8_bin; grant all on jiradb.* to jira@$ipaddress identified by 'Admin@123'; grant all on jiradb.* to jira@localhost identified by 'Admin@123'; grant all on jiradb.* to jira@$fqdn identified by 'Admin@123'; grant all on jiradb.* to jira@127.0.0.1 identified by 'Admin@123'; flush privileges; \"",
}
}

