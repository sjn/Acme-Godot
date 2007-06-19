# This is a -*- perl -*- test script for checking module "kwalitee"
#

use strict;
use warnings;
use Test::More;

plan skip_all => 'For authors only (set PERL_AUTHOR_TEST to run.)'
    unless $ENV{PERL_AUTHOR_TEST};

eval 'use Test::Kwalitee;';  ## no critic
plan skip_all => 'Test::Kwalitee not installed; skipping'
    if $@;

# No explicit test run, it's all done at use() time

