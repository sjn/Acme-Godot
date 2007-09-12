# This is a -*- perl -*- distribution test file for checking modules if
# they follow the suggestions in Damian Conway's marvellous book
# "Perl Best Practices", O'Reilly & Associates, 2005, ISBN 0-596-00173-8
#

use strict;
use warnings;
use Test::More;

plan skip_all => 'For authors only (set PERL5_AUTHOR_TEST to run.)'
    unless $ENV{PERL5_AUTHOR_TEST};

eval 'use Test::Perl::Critic;';  ## no critic
plan skip_all => "Test::Perl::Critic required for testing PBP compliance"
    if $@;

eval 'use Perl::Critic::Utils qw(all_perl_files);';  ## no critic
plan skip_all => "Perl::Critic::Utils required for testing PBP compliance"
    if $@;

my @files = ( all_perl_files('blib'), grep {m/\.t\z/} all_perl_files('t') );
plan tests => scalar @files;
for my $file (@files) {
   critic_ok( $file, $file );
}
