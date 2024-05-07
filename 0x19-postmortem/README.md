# POSTMORTEM

When the release of BreezeTech software suites patch was pushed to production, at around 12:00 East African Time (EAT), an outage was experienced on the isolated containers ubuntu 20.0, 
running on the virtual private server from AWS cloud. Requests to the server led to `500 Internal Server Error` or either high latency,
the expected response was the home page of our application for our system.

# Debugging process

Our SRE(Site Reliability Engineer) Caleb Baraka was up for the spot, faced the issue upon opening the project,
following some instructions from developers and the IT support team at around 14:00 EAT.
He followed these steps to solve the issue:

1. Confirmed the processes running using `ps aux`. Two `apache2` processes `root` and `www-data` were running as expected.


2. Looked in the `sites-available` folder of the `/etc/apache2/` directory. Determined that
the web server was serving content located in `/var/www/html/`.


3. In one terminal, ran `strace` on the PID of the `root` Apache process. In another, curled
the server. Expected great things... only to be disappointed. `strace` gave no useful
information.

4. Repeated step 3, except on the PID of the `www-data` process. Kept expectations lower this
time... but was rewarded! `strace` revelead an `-1 ENOENT (No such file or directory)` error
occurring upon an attempt to access the file `/var/www/html/wp-includes/class-wp-locale.ppy`.

5. Looked through files in the `/var/www/html/` directory one-by-one, using Vim pattern
matching to try and locate the erroneous `.ppy` file extension. Located it in the
`urls.py` file. (Line 137, `path( ABSPATH . WPINC . '/class-wp-locale.py' );`).

6. Removed the trailing `p` from the line.

7. Tested another `curl` on the server. 200 A-ok!

8. Wrote a Puppet manifest to automate fixing of the error.

## Summation

In short, a typo. Gotta love'em. In full, the WordPress app was encountering a critical
error in `wp-settings.php` when tyring to load the file `class-wp-locale.phpp`. The correct
file name, located in the `wp-content` directory of the application folder, was
`class-wp-locale.php`.

Patch involved a simple fix on the typo, removing the trailing `p`.

## Prevention

The outage was an application error rather than a web server error,
To prevent such outages in the future moving forward, the following should be taken seriously.

* Ignorance is the motherfucker of everything, Tests! Tests!, any patch or upgrades should be tested before deploying.
The error could have been addressed earlier if the app had been tested.

* Status monitoring. Enable some uptime-monitoring service such as
[UptimeRobot](./https://uptimerobot.com/) to alert instantly upon outage of the website.

Also not forgetting in response to this error i crafted a puppet manifest to solve the small bug

