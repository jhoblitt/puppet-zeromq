#
# = Class: zeromq::params
#
# This class should be considered private.
#
#
class zeromq::params {
  $default_version = '3'

  case $::osfamily {
    'RedHat': {
      $os_id = "${::osfamily} ${::operatingsystemmajrelease}"

      case $::operatingsystemmajrelease {
        '6': {
          $zeromq3_package_name = [ 'zeromq3', 'zeromq3-devel' ]
          $czmq_package_name    = [ 'czmq', 'czmq-devel' ]
        }
        '7': {
          $zeromq3_package_name = [ 'zeromq3', 'zeromq3-devel' ]
          $zeromq4_package_name = [ 'zeromq', 'zeromq-devel' ]
          $czmq_package_name    = [ 'czmq', 'czmq-devel' ]
        }
        default: {
          fail("Module ${module_name} is not supported on ${os_id}")
        }
      }
    }
    'Debian': {
      # czmq does not appear to be packaged for Debian yet
      $os_id = "${::osfamily} ${::lsbdistcodename}"

      case $::lsbdistcodename {
        'sid': {
          $zeromq3_package_name = [ 'libzmq3', 'libzmq3-dev' ]
        }
        default: {
          fail("Module ${module_name} is not supported on ${os_id}")
        }
      }
    }
    'Gentoo': {
      $os_id                   = $::osfamily
      $zeromq3_package_name    = 'net-libs/zeromq'
      $zeromq4_package_name    = $zeromq3_package_name
      $zeromq3_package_version = '3*'
      $zeromq4_package_version = '4*'
      $czmq_package_name       = 'net-libs/czmq'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }
}
