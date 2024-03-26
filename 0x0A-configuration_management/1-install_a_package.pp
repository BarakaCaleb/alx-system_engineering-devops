# Using Puppet to install Flask from pip 3
# Requirements 
#            install Flask
#            Must version 2.1.0

exec {
    'install_flask':
    command => '/usr/bin/pip3 install flask==2.1.0',
    path => ['/usr/bin/'],
    unless => '/usr/bin/pip3 show flask | grep -q "Version: 2.1.0",
}