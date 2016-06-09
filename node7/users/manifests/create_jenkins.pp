class users::create_jenkins {
       user{ "jenkins" :
       ensure           => 'present',
       home             => "/home/jenkins",
       shell            => '/bin/bash',
       managehome => true,
     }
}

