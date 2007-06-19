# This is a -*- perl -*- test script for checking module use()-ability
#

use strict;
use warnings;
use Test::More tests => 1;
use Test::Exception;

throws_ok {
    local $SIG{ALRM} = sub { die "Waiting no more\n" };
    alarm 5;
    require Acme::Godot;
    alarm 0;
} qr/Waiting no more/, "Godot didn't arrive";
