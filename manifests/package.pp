class psgiserver::package {

  case $::operatingsystem {
    centos,fedora,rhel: {
      class { 'psgiserver::package::redhat':
      }
    }
    debian,ubuntu: {
      class { 'psgiserver::package::debian':
      }
    }
    default: { fail('Unrecognised operating system') }
  }
}
