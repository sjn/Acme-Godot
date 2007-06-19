# This is a -*- perl -*- test script for checking module if the default
# boilerplate text in the generated files have been changed.
#
# This test is based on an idea by José Alves de Castro (CPAN-id: COG)
# found in his Acme::CreatingCPANModules London.pm talk.
#

use strict;
use warnings;
use Test::More;

plan skip_all => 'For authors only (set PERL_AUTHOR_TEST to run.)'
    unless $ENV{PERL_AUTHOR_TEST};

plan tests => 3;

not_in_file_ok(README =>
    "'The README is used...' boilerplate text"    => qr/The README is used/,
    "'version information here' boilerplate text" => qr/to provide version information/,
);

SKIP: {
    skip "- Need some natural boilerplate text in Changes file.", 1;
    not_in_file_ok(Changes =>
        "placeholder date/time" => qr(Date/time),
    );
};

module_boilerplate_ok('Acme::Godot');


#
# Methods
#

sub not_in_file_ok {
    my ($filename, %regex) = @_;
    open my $fh, "<", $filename
        or die "couldn't open $filename for reading: $!";

    my %violated;

    while (my $line = <$fh>) {
        while (my ($desc, $regex) = each %regex) {
            if ($line =~ $regex) {
                push @{$violated{$desc}||=[]}, $.;
            }
        }
    }

    if (%violated) {
        fail("That $filename contains no boilerplate text");
        diag "    - $_ appears on lines @{$violated{$_}}" for keys %violated;
    } else {
        pass("That $filename contains no boilerplate text");
    }
}

sub module_boilerplate_ok {
    my ($module) = @_;
    my $filename = $module;
    $filename =~ s,::,/,g; $filename = "lib/$filename.pm";
    not_in_file_ok($filename =>
        'NAME section boilerplate text' => qr/One line description of module's purpose/,
        'unedited SYNOPSIS example'     => qr/my \$foo =/,
        'nonsensical DESCRIPTION'       => qr/This is the great module/,
        'DIAGNOSTICS boilerplate text'  => qr/Description of error here/,
    );
}

