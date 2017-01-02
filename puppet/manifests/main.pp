Exec {
  path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"] }

node default {
}

node "build.local" {
    hiera_include('classes')
#    class {'docker::compose':
#      ensure => present,
#    }
    $my_hash = hiera('docker_compose', {})
    create_resources('docker_compose', $my_hash)

}
