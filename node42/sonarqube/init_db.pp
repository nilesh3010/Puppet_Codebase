class sonardb{



 exec { "createdb":
        command => "/usr/bin/mysql -u root -p Admin@123 -e \"create database sonarqubedb  CHARACTER SET utf8 COLLATE utf8_general_ci;
 grant all on sonardb.* to sonar@$SONARQUBE_IPADDRESS1 identified by 'Admin@123';
 grant all on sonardb.* to sonar@localhost identified by 'Admin@123';
 grant all on sonardb.* to sonar@$SONARQUBE_IPADDRESS2 identified by 'Admin@123';
 grant all on sonardb.* to sonar@$MYSQL1 identified by 'Admin@123';
 grant all on sonardb.* to sonar@127.0.0.1 identified by 'Admin@123';
 grant all on sonardb.* to sonar@$MYSQL2 identified by 'Admin@123';
 grant all on sonardb.* to sonar@$SONARQUBE_HOSTNAME1 identified by 'Admin@123';
 grant all on sonardb.* to sonar@$SONARQUBE_HOSTNAME2 identified by 'Admin@123';
 grant all on sonardb.* to sonar@$MYSQL_HOSTNAME1 identified by 'Admin@123';
 grant all on sonardb.* to sonar@$MYSQL_HOSTNAME2 identified by 'Admin@123';
 flush privileges; \"",

