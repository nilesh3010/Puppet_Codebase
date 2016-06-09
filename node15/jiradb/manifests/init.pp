class jiradb{



 exec { "createdb":
        command => "/usr/bin/mysql -u root -p Admin@123 -e \"create database jiradb;
 grant all on jiradb.* to jira@$ipaddress identified by 'Admin@123';
 grant all on jiradb.* to jira@localhost identified by 'Admin@123';
 grant all on jiradb.* to jira@$hostname identified by 'Admin@123';
 grant all on jiradb.* to jira@127.0.0.1 identified by 'Admin@123';
 flush privileges; \"",
   
    }
}
