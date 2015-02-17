# The below attributes all change the behaviour of mod_evasive; the descriptions
# are taken directly from the default config provided by the EPEL RPM.

# The hash table size defines the number of top-level nodes for each
# child's hash table.  Increasing this number will provide faster
# performance by decreasing the number of iterations required to get to the
# record, but consume more memory for table space.  You should increase
# this if you have a busy web server.  The value you specify will
# automatically be tiered up to the next prime number in the primes list
# (see mod_evasive.c for a list of primes used).
default['apache']['mod_evasive']['dos_hash_table_size'] = 3097

# This is the threshhold for the number of requests for the same page (or
# URI) per page interval.  Once the threshhold for that interval has been
# exceeded, the IP address of the client will be added to the blocking
# list.
default['apache']['mod_evasive']['dos_page_count'] = 2

# This is the threshhold for the total number of requests for any object by
# the same client on the same listener per site interval.  Once the
# threshhold for that interval has been exceeded, the IP address of the
# client will be added to the blocking list.
default['apache']['mod_evasive']['dos_site_count'] = 50

# The interval for the page count threshhold; defaults to 1 second
# intervals.
default['apache']['mod_evasive']['dos_page_interval'] = 1

# The interval for the site count threshhold; defaults to 1 second
# intervals.
default['apache']['mod_evasive']['dos_site_interval'] = 1

# The blocking period is the amount of time (in seconds) that a client will
# be blocked for if they are added to the blocking list.  During this time,
# all subsequent requests from the client will result in a 403 (Forbidden)
# and the timer being reset (e.g. another 10 seconds).  Since the timer is
# reset for every subsequent request, it is not necessary to have a long
# blocking period; in the event of a DoS attack, this timer will keep
# getting reset.
default['apache']['mod_evasive']['dos_blocking_period'] = 10

# If this value is set, an email will be sent to the address specified
# whenever an IP address becomes blacklisted.  A locking mechanism using
# /tmp prevents continuous emails from being sent.
#
# NOTE: Requires /bin/mail (provided by mailx)
default['apache']['mod_evasive']['dos_notify_email'] = nil

# If this value is set, the system command specified will be executed
# whenever an IP address becomes blacklisted.  This is designed to enable
# system calls to ip filter or other tools.  A locking mechanism using /tmp
# prevents continuous system calls.  Use %s to denote the IP address of the
# blacklisted IP.
default['apache']['mod_evasive']['dos_system_command'] = nil

# Choose an alternative temp directory By default "/tmp" will be used for
# locking mechanism, which opens some security issues if your system is
# open to shell users.
#
#   http://security.lss.hr/index.php?page=details&ID=LSS-2005-01-01
#
# In the event you have nonprivileged shell users, you'll want to create a
# directory writable only to the user Apache is running as (usually root),
# then set this in your httpd.conf.
default['apache']['mod_evasive']['dos_log_dir'] = nil


# You can use whitelists to disable the module for certain ranges of
# IPs. Wildcards can be used on up to the last 3 octets if necessary.  
# Multiple DOSWhitelist commands may be used in the configuration; just
# add to the array.
default['apache']['mod_evasive']['dos_white_list'] = [ "127.0.0.1" ]
