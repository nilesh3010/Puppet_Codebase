class users::create_jfrog {
       user{ "jfrog" :
       ensure           => 'present',
       home             => "/home/jfrog",
       shell            => '/bin/bash',
       managehome => true,
     }
}

