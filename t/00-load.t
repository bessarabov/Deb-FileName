#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use open qw(:std :utf8);

use Test::More tests => 1;

use Deb::FileName;

my $version = $Deb::FileName::VERSION;

$version = "(unknown version)" if not defined $version;

ok(1, "Testing $version, Perl $], $^X" );
