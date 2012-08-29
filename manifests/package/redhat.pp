class psgiserver::package::redhat {
#Currently RHEL/CentOS (6.2) does not provide a perl-Starman rpm
#this comes from a local yum repo
  $redhat_packages = ['perl-Starman']
  package { $redhat_packages:
    ensure => present
  }
}
