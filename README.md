ptero-perl-sdk
==============
[![Build Status](https://travis-ci.org/genome/ptero-perl-sdk.svg?branch=master)](https://travis-ci.org/genome/ptero-perl-sdk)

Perl interface to the PTero services

To setup Carton on Debian-based Linux:

    $ sudo apt-get install carton

Or on a system using [Plenv](https://github.com/tokuhirom/plenv):

    $ plenv install-cpanm
    $ cpanm install Carton
    $ plenv rehash

Once your have Carton:

    $ carton install --deployment # from the root of this repo

To run tests:

    $ carton exec prove -vrl t/
