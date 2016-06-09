class zabbix::zabbix
{
        exec { "create":
command => "/usr/bin/mysql -uroot -pAdmin@123 -e \"create database zabbixdb CHARACTER SET utf8 COLLATE utf8_bin; grant all on zabbixdb.* to zabbix@$ipaddress identified by 'Admin@123'; grant all on zabbixdb.* to zabbix@localhost identified by 'Admin@123'; grant all on zabbixdb.* to zabbix@$fqdn identified by 'Admin@123'; grant all on zabbixdb.* to zabbix@127.0.0.1 identified by 'Admin@123'; flush privileges; \"",
}
}
