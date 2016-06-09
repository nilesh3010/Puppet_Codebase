class sonarqube::db
{
        exec { "createdb":
        command => "/usr/bin/mysql -uroot -pAdmin@123 -e \"create database sonarqubedb CHARACTER SET utf8 COLLATE utf8_general_ci; grant all on sonarqubedb.* to sonar@$ipaddress identified by 'Admin@123'; grant all on sonarqubedb.* to sonar@localhost identified by 'Admin@123'; grant all on sonarqubedb.* to sonar@$hostname identified by 'Admin@123'; grant all on sonarqubedb.* to sonar@127.0.0.1 identified by 'Admin@123'; flush privileges; \"",

    }
}

