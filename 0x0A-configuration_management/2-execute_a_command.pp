# Using Puppet to create a manifest file that kills a process called killmenow
# Requirements:

    # Must use the exec Puppet resource
    # Must use pkill

# Kills a process named killmenow

exec { 'pkill -f killmenow':
  path => '/usr/bin/:/usr/local/bin/:/bin/'
}