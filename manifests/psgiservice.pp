# define psgiserver::psgiservice
#
# This definition creates a psgi service.
# *ensure*
#    set this to absent is you want puppet to remove files, stop/disable the service, defaults to 'present'
# *appservertype*
#    starman or start_server, this should be the name of the binary
# *listenip*
#   Specifies which network address to bind to use, probably either * or 127.0.0.1, default *.
# *listenport*
#   Specifies the port to bind to wait for requests.
#   Defaults to port 9000
# *socket*
#   Unix domain socket for the appserver to listen to.
# *pidfile*
#
# *logfile*
#
# *env*
#   Specifies the value for the -E parameter to starman.
#   Starman defaults to 'deployment', but this parameter defaults to 'production'.
#   For dancer apps, ensure there is a config file in environments/${env}.yml
#
# *rootdir*
#   Specify an absolute path for the root of the app
#
# *app_exec*
#   Specifies an absolute path to the executable psgi file
#
# === Examples
#
# psgiserver::psgiservice { "npi":
#  rootdir  => '/opt/npi',
#  app_exec => '/opt/npi/bin/npi.psgi'
# }
#
define psgiserver::psgiservice (
    $ensure         = 'present',
    $appservertype  = 'starman',
    $listenport     = '9000',
    $listenip       = '*',
    $socket         = "/var/run/${name}.sock",
    $pidfile        = "/var/run/${name}.pid",
    $logfile        = "/var/log/${name}.log",
    $debugstatus    = 0,
    $username       = 'nobody',
    $description    =  '',
    $workers        = '10',
    $env            = 'production',
    $rootdir        = "/var/apps/${name}",
    $app_exec       = "${rootdir}/${name}.psgi"

) {
      $listen = "${listenip}:${listenport}"
      file { "/etc/init.d/${name}":
        ensure  => $ensure,
        owner   => $username,
        content => template("psgiserver/initscript.erb"),
        mode    => '0755',
        notify  => Service[$name]
      }

      case $ensure {
        'present': {
          service { $name:
            ensure      => 'running',
            enable      => true,
            hasrestart  => true,
            hasstatus   => true,
            require     => File["/etc/init.d/${name}"]
          } #end service
        } #end case present
        'absent': {
          service { $name:
            ensure      => 'stopped',
            enable      => false,
            hasrestart  => true,
            hasstatus   => true,
            require     => File["/etc/init.d/${name}"]
            } #end service
          } #end case absent


        } #end case $ensure
        file { "/etc/logrotate.d/${name}":
          ensure  => $ensure,
          content => template("psgiserver/logrotate.erb"),
        }
}
