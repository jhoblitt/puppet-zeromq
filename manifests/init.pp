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
  validate_string($version)

  $zeromq_package         = getvar("zeromq::params::zeromq${version}_package")
  $zeromq_package_version = getvar("zeromq::params::zeromq${version}_package_version")
  $os_id                  = $zeromq::params::os_id

  if $zeromq_package == undef {
    fail("zeromq API version ${version} is not supported on ${os_id}")
  }

  # Not all platforms encode the API version of the zermq package in the
  # package's name, some (Gentoo) need to use an explict version string.
  $package_ensure = $zeromq_package_version ? {
    undef   => 'present',
    default => $zeromq_package_version,
  }

  package { $zeromq_package:
    ensure => $package_ensure,
  }
}
