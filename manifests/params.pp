# Class: polipo::params
#
#
class polipo::params {
  case $::osfamily {
    'debian','redhat': {
      $polipo_cachedir = '/var/cache/polipo/'
      $polipo_name     = 'polipo'
      $polipo_pkg      = 'polipo'
      $polipo_user     = 'proxy'
      $polipo_group    = 'proxy'
      $polipo_confdir  = '/etc/polipo'
      $polipo_pidfile  = '/var/run/polipo/polipo.pid'
    }
    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
