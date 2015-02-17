# mod_evasive-cookbook

Installs and configures mod_evasive for Apache.


## Supported Platforms

* CentOS/RHEL/Fedora

## Attributes
Descriptions and defaults taken from the config that ships with the EPEL
RPM.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_hash_table_size']</tt></td>
    <td>Integer</td>
    <td>The hash table size defines the number of top-level nodes for each
    child's hash table.  Increasing this number will provide faster
    performance by decreasing the number of iterations required to get to the
    record, but consume more memory for table space.  You should increase
    this if you have a busy web server.  The value you specify will
    automatically be tiered up to the next prime number in the primes list
    (see mod_evasive.c for a list of primes used).</td>
    <td><tt>3097</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_page_count']</tt></td>
    <td>Integer</td>
    <td.This is the threshhold for the number of requests for the same page (or
    URI) per page interval.  Once the threshhold for that interval has been
    exceeded, the IP address of the client will be added to the blocking
    list.</td>
    <td><tt>2</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_site_count']</tt></td>
    <td>Integer</td>
    <td>This is the threshhold for the total number of requests for any object by
    the same client on the same listener per site interval.  Once the
    threshhold for that interval has been exceeded, the IP address of the
    client will be added to the blocking list.</td>
    <td><tt>50</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_page_interval']</tt></td>
    <td>Integer</td>
    <td>The interval for the page count threshhold; defaults to 1 second
    intervals.</td>
    <td><tt>1</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_site_interval']</tt></td>
    <td>Integer</td>
    <td>The interval for the site count threshhold; defaults to 1 second
    intervals.</td>
    <td><tt>1</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_blocking_period']</tt></td>
    <td>Integer</td>
    <td>The blocking period is the amount of time (in seconds) that a client will
    be blocked for if they are added to the blocking list.  During this time,
    all subsequent requests from the client will result in a 403 (Forbidden)
    and the timer being reset (e.g. another 10 seconds).  Since the timer is
    reset for every subsequent request, it is not necessary to have a long
    blocking period; in the event of a DoS attack, this timer will keep
    getting reset.</td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_notify_email']</tt></td>
    <td>String or nil</td>
    <td>If this value is set, an email will be sent to the address specified
    whenever an IP address becomes blacklisted.  A locking mechanism using
    /tmp prevents continuous emails from being sent.
   
    NOTE: Requires /bin/mail (provided by mailx)</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_system_command']</tt></td>
    <td>String or nil</td>
    <td>If this value is set, the system command specified will be executed
    whenever an IP address becomes blacklisted.  This is designed to enable
    system calls to ip filter or other tools.  A locking mechanism using /tmp
    prevents continuous system calls.  Use %s to denote the IP address of the
    blacklisted IP.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_log_dir']</tt></td>
    <td>String or nil</td>
    <td>Choose an alternative temp directory By default "/tmp" will be used for
    locking mechanism, which opens some security issues if your system is
    open to shell users.
   
      http://security.lss.hr/index.php?page=details&ID=LSS-2005-01-01
   
    In the event you have nonprivileged shell users, you'll want to create a
    directory writable only to the user Apache is running as (usually root),
    then set this in your httpd.conf.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['mod_evasive']['dos_white_list']</tt></td>
    <td>Array</td>
    <td>You can use whitelists to disable the module for certain ranges of
    IPs. Wildcards can be used on up to the last 3 octets if necessary.  
    Multiple DOSWhitelist commands may be used in the configuration; just
    add to the array.</td>
    <td><tt>[ "127.0.0.1" ]</tt></td>
  </tr>
</table>

## Usage

### mod_evasive::default

Include `mod_evasive` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[mod_evasive::default]"
  ]
}
```

## License and Authors

Author:: AzTek Native Ltd. (<peter.green@aztek-native.com>)
