# Class: polipo::params
#
#
class polipo::params {
  case $::osfamily {
    'debian': {
      $polipo_confdir  = '/etc/polipo'
      $polipo_cachedir = '/var/cache/polipo/'
      $polipo_pidfile  = '/var/run/polipo/polipo.pid'
      $polipo_name     = 'polipo'
      $polipo_pkg      = 'polipo'
      $polipo_user     = 'proxy'
      $polipo_group    = 'proxy'
    }
    'redhat': {
      $polipo_confdir  = '/etc/polipo'
      $polipo_cachedir = '/var/cache/polipo/'
      $polipo_pidfile  = '/var/run/polipo/polipo.pid'
      $polipo_name     = 'polipo'
      $polipo_pkg      = 'polipo'
      $polipo_user     = 'proxy'
      $polipo_group    = 'proxy'
    }
    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
