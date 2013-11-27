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

  # class zeromq needs to appear before zeromq::czmq in the catalog for two
  # reasons:
  # - it may have a version string set and in the future czmq may do
  # something with that
  # - so an ordering construct like Class['epel'] -> Class['zeromq'] will take
  # affect before this class
  anchor { 'zeromq::czmq::begin': } ->
  Class['zeromq'] ->
  package { $package_name:
    ensure => 'present',
  } ->
  anchor { 'zeromq::czmq::end': }
}
