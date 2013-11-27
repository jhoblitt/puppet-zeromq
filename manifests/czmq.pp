#
# = Class: zeromq::czmq
#
# Manages the czmq package
#
#
# == Parameters
#
# Refer to https://github.com/jhoblitt/puppet-zeromq for official documentation
#
#
class zeromq::czmq {
  include zeromq, zeromq::params

  $os_id        = $zeromq::params::os_id
  $package_name = $zeromq::params::czmq_package_name

  if $package_name == undef {
    fail("czmq package is not supported on ${os_id}")
  }

  package { $package_name:
    ensure => 'present',
  }
}
