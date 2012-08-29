# == Class: psgiserver
#
# This module enables puppet to manage perl application servers.
#
# It:
# *installs dependencies
# *provides an initscript and a service
# *provides a logrotate fragment for /etc/logrotate.d/
#
# === Parameters
# *from*          - Use package repositories (yum/apt) or cpan (package|cpanm)
#
# === Examples
#
# class { 'psgiserver':
#  from => 'cpanm'
# }
#
# === Authors
#
# Duncan Hutty <dhutty@allgoodbits.org>
#
# === Copyright
#
# Copyright 2012 Duncan Hutty
class psgiserver ( $from = 'package' )
{
  case $from {
    package: {
      class { 'psgiserver::package': }
    }
    cpanm: {
      class { 'psgiserver::cpanm': }
    }
    default: { fail('Unrecognised from, use from => [\'package\',\'cpanm\']') }
  }
}
