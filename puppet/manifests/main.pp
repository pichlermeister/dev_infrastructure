Exec {
  path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

node default {
}

node "git.local" {
    include 'docker'
    class {'docker::compose': 
      ensure => present,
    }
    docker_compose { '/vagrant/docker/gitlab/docker-compose.yml':
      ensure  => present,
    }
}

node "build.local" {
    include 'docker'
    class {'docker::compose': 
      ensure => present,
    }
    hiera_include('classes')

    docker_compose { '/vagrant/docker/jenkins/docker-compose.yml':
      ensure  => present,
    }
    docker_compose { '/vagrant/docker/nexus/docker-compose.yml':
      ensure  => present,
    }
    docker_compose { '/vagrant/docker/sonar/docker-compose.yml':
      ensure  => present,
    }
}