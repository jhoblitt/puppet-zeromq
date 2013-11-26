#
# = Class: zeromq
#
# Manages the zeromq package(s)
#
#
# == Parameters
#
# Refer to https://github.com/jhoblitt/puppet-zeromq for official documentation
#
#
class zeromq(
  $version = $zeromq::params::default_version
) inherits zeromq::params {

  $zeromq_package = getvar("zeromq::params::zeromq${version}_package")
  $os_id          = $zeromq::params::os_id

  if $zeromq_package == undef {
    fail("zeromq API version ${version} is not supported on ${os_id}")
  }

  package { $zeromq_package:
    ensure => present,
  }
}
