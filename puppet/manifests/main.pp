Exec {
  path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

node default {
}

node "build.local" {
    include 'docker'
    class {'docker::compose': 
      ensure => present,
    }
    hiera_include('classes')
    
    $my_hash = hiera('docker_compose', {})
    create_resources('docker_compose', $my_hash)

}