#! /usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use DBTools;

my $usage = "Usage: lookup-game.pl [GAME REGEXP]\n";

my $gameRE = shift @ARGV;
if (not defined $gameRE or $gameRE =~ /^(-h|--help)$/)
{
    print $usage;
    exit 0;
}

my $db_path = "$FindBin::Bin/mgl.db";

my @db = DBTools::loadDB($db_path);
my $i = 1;
foreach my $record (@db)
{
    my $game = $record->{'game'};
    print "$i ($game)\n" if $game =~ /$gameRE/i;
    $i ++;
}
exit 0;

