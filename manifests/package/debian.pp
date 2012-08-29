class psgiserver::package::debian {
  $debian_packages = ['starman']
  package { $debian_packages:
    ensure => present
  }
}
