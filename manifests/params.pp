#
# = Class: zeromq::params
#
# This class should be considered private.
#
#
class zeromq::params {
  $default_version = 3

  case $::osfamily {
    'RedHat': {
      $os_id = "${::osfamily} ${::operatingsystemmajrelease}"

      case $::operatingsystemmajrelease {
        6: {
          $zeromq3_package = [ 'zeromq3', 'zeromq3-devel' ]
        }
        default: {
          fail("Module ${module_name} is not supported on ${os_id}")
        }
      }
    }
    'Debian': {
      $os_id = "${::osfamily} ${::lsbdistcodename}"

      case $::lsbdistcodename {
        'sid': {
          $zeromq3_package = [ 'libzmq3', 'libzmq3-dev' ]
        }
        default: {
          fail("Module ${module_name} is not supported on ${os_id}")
        }
      }
    }
    'Gentoo': {
      $os_id                   = $::osfamily
      $zeromq3_package         = 'net-libs/zeromq'
      $zeromq4_package         = $zeromq3_package
      $zeromq3_package_version = '3*'
      $zeromq4_package_version = '4*'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }
}
