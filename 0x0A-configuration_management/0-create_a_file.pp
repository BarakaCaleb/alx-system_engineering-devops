# Puppet manifest to create a file in/tmp

# Define the file resource
file { '/tmp/school':
  ensure => file,
  mode   => '044',
  owner  => 'www-data',
  group  => 'www-data'
  content => "I love Puppet\n",
}