# Ensure that pip3 is installed
package { 'python3-pip':
  ensure => installed,
}

# Install Flask version 2.1.0 using pip3
exec { 'install_flask':
  command => '/usr/bin/pip3 install flask==2.1.0',
  path    => ['/usr/bin'],
  unless  => '/usr/bin/pip3 show flask | grep -q "Version: 2.1.0"',
}

# Ensure Flask is installed globally
file { '/usr/local/bin/flask':
  ensure => link,
  target => '/usr/local/bin/flask',
  require => Exec['install_flask'],
}