# Class: polipo
#
# This class installs polipo
#
# Parameters:
#
# Actions:
#   - Install polipo
#
# Requires:
#   - ... module
#
# Sample usage:
#   node host01 {
#     class { 'polipo':
#       proxyname => 'host01'
#     }
#   }
#
# Valid options:
#
#   method         => 'any',
#   proxyaddress   => '::0',        # default: '::0' | ipv4 + ipv6: '::0', ipv4: '0.0.0.0'
#   allowedclients => '127.0.0.1',  # default: any   | any static manual dhcp bootp ppp wvdial
#   proxyname      => 'foobar',     # default: $hostname
#   sharedcache    => 'false'
#
# When a file called forbidden-$fqdn is present it will
# be used to override the default forbidden list.
#
class polipo (
  $method         = 'any',
  $proxyaddress   = '::0',
  $allowedclients = '127.0.0.1',
  $proxyname      = "\"${::hostname}\"",
  $sharedcache    = 'false'
) inherits polipo::params {
  package {'polipo':
    ensure => installed,
    name   => $polipo::polipo_pkg,
  }

  File{
    require => Package['polipo'],
    }

    file {$polipo::params::polipo_confdir:
      ensure => directory,
    }

    file{'polipoconf':
      ensure  => file,
      path    => "${polipo::params::polipo_confdir}/config",
      content => template ('polipo/config.erb'),
    }

    file{"${polipo::params::polipo_confdir}/forbidden":
      ensure   => file,
      content  => template('polipo/forbidden.erb'),
    }

    file{"${polipo::params::polipo_confdir}/options":
      ensure  => file,
      content => template ('polipo/options.erb');
    }

    file{$polipo::params::polipo_cachedir:
      ensure => directory,
    }

    cron {'Purge Polipo cache every two weeks':
      command  => "kill -USR1 $(cat ${polipo::params::polipo_pidfile}); sleep 1; polipo -x; kill -USR2 $(cat ${polipo::params::polipo_pidfile})",
      user     => 'root',
      month    => '*',
      monthday => ['1', '14'],
      hour     => '0',
      minute   => '0',
    }

    service {$polipo::params::polipo_name:
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => false,
      subscribe  => File['polipoconf'],
    }
  }
