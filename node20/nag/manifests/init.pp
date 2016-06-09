class nag
{
require 'nagrpms'

group {'nagcmd':
ensure => 'present',
gid => '765',
}
user{'nagios':
ensure => 'present',
home =>'/home/nagios',
managehome =>'yes',
#uid => '987',
groups =>'nagcmd',
}
include 'nag::nagios'
include 'nag::plugins'
include 'nag::nrpe'
include 'nag::config'
}
