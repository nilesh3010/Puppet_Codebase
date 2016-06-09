class users::create_jira {
       user{ "jira" :
       ensure           => 'present',
       home             => "/home/jira",
       shell            => '/bin/bash',
       managehome => true,
     }
}
