class psgiserver::cpanm {
  exec { 'cpanm-starman':
    command => 'cpanm Starman',
    unless  => 'perl -MStarman -e1;'
  }

}
