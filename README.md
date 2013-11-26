Puppet zeromq Module
====================

[![Build Status](https://travis-ci.org/jhoblitt/puppet-zeromq.png)](https://travis-ci.org/jhoblitt/puppet-zeromq)

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Usage](#usage)
4. [Limitations](#limitations)
5. [Versioning](#versioning)
6. [Support](#support)
7. [See Also](#see-also)


Overview
--------

Manages the `zeromq` package(s)


Description
-----------

This module will install the [`zeromq`](http://zeromq.org/) library and header
packages.  Only operating systems that have packages for at least `zermq`
version 3+ API are supported. Version 3 packages will be installed by default
but if your operating system has version 4 package(s), they may optionally
specified


Usage
-----

```puppet
include zeromq
```

```puppet
class { 'zeromq': }
```

```puppet
class { 'zeromq':
  version => 3, #default
}
```

At present, `version => 4` (or any version value other than 3) is only
supported on Gentoo.

```puppet
class { 'zeromq':
  version => 4,
}
```


Limitations
-----------

This module presently aims to support these operatingsystems:

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

* [zeromq](http://zeromq.org/)
