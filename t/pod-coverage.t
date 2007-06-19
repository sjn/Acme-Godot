# This is a -*- perl -*- test script for checking module documentation coverage
#

use strict;
use warnings;
use Test::More;

plan skip_all => 'No point in covering an empty API';

eval 'use Test::Pod::Coverage 1.04;';  ## no critic
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;

all_pod_coverage_ok();
