# This fixes bad `phhp` extension to `php` in the wordpress file `wp-settings.php`

exec { 'fix-wordpress':
  command => 'sed -i s/phhp/php/g /var/www/html/wp-settings.php',
  path    => '/usr/local/bin/:/bin/'
}

