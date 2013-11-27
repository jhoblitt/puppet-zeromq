Puppet zeromq Module
====================

[![Build Status](https://travis-ci.org/jhoblitt/puppet-zeromq.png)](https://travis-ci.org/jhoblitt/puppet-zeromq)

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Usage](#usage)
    * [Simple](#simple)
    * [`zeromq`](#zeromq)
    * [`zeromq::czmq`](#zeromq--czmq)
4. [Limitations](#limitations)
5. [Versioning](#versioning)
6. [Support](#support)
7. [See Also](#see-also)


Overview
--------

Manages the `zeromq` and `czmq` packages


Description
-----------

This module will install the [`zeromq`](http://zeromq.org/), commonly called
`zmq` or `0mq`, library and header packages.  Only operating systems that have
packages for at least the `zeromq` version 3+ API are supported.  Version 3
packages will be installed by default but if your operating system has version
4 package(s), they may optionally be specified.

This module can also install the [`czmq`](http://czmq.zeromq.org/) library and
headers.  Subject to availability of packages for your operating system.


Usage
-----

### Simple

```puppet
include zeromq
```

```puppet
# includes zeromq for you
include zeromq::czmq
```

### `zeromq`

This class will install the `zeromq` library and header packages (if they
separately packaged).

```puppet
# defaults
class { 'zeromq':
  version => 3
}
```

#### Parameters

* `version`

    `String` defaults to: `3`

    Controls which set of `zeromq` packages for major API `version` is
    installed.  At present, `version => 4` (or any version value other than 3)
    is only supported on Gentoo.

#### `$osfamily == RedHat` considerations

The el6.x packages are provided by EPEL6 but this module does not configure nor
have a dependency on a module that will configure a EPEL6 yumrepo.  This is to
avoid potentially conflicting with a local yumrepo configuration, which is
fairly common for sites that have more than a hand full of nodes.

If you do not have a local site setup, the
[`stahnma/epel`](https://forge.puppetlabs.com/stahnma/epel) module is a good
option for configuring EPEL6.

You will likely want to declare resource ordering in your catalog to ensure
that the EPEL6 repo is configured *before* this module in the catalog. Eg:

```puppet
Class['epel'] -> Class['zeromq']
include epel
include zeromq
```

### `zeromq::czmq`

This class will install the `czmq` library and header packages (if they
separately packaged).

```puppet
# defaults
class { 'zeromq::czmq': }
```

The `zeromq` class is included by this class so there's no reason to declare
both in the manifest unless default parameters on `zeromq` need to be
overridden.

```puppet
include zeromq # <= not needed
include zeromq::czmq
```

```puppet
class { 'zeromq':
  version => 4 # <= changing default
}
include zeromq::czmq
```

#### Parameters

This class currently accepts no options.


Limitations
-----------

This module presently aims to support these operating systems:

* RedHat
  - 6
* Debian
  - sid
* Gentoo
  - ~13.0


Versioning
----------

This module is versioned according to the [Semantic Versioning
2.0.0](http://semver.org/spec/v2.0.0.html) specification.


Support
-------

Please log tickets and issues at
[github](https://github.com/jhoblitt/puppet-zeromq/issues)


See Also
--------

* [`zeromq`](http://zeromq.org/)
* [`czmq`](http://czmq.zeromq.org/)
* [`stahnma/epel`](https://forge.puppetlabs.com/stahnma/epel)
