## Requirements
  On a Redhat machine you need to have Epel setup. 

## Sample usage

	node host01 {
	  class { 'polipo':
	    sharedcache => 'true'
	  }
	}

## Valid options

	method         => 'any',
	proxyaddress   => '::0',        # default: '::0' | ipv4 + ipv6: '::0', ipv4: '0.0.0.0'
	allowedclients => '127.0.0.1',  # default: any   | any static manual dhcp bootp ppp wvdial
	proxyname      => 'foobar',     # default: $hostname
	sharedcache    => 'false'
  forbiden       => []
