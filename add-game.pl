#! /usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use DBTools;

my $usage = "Usage: add-game.pl [GAME] [COMMAND] [INDEX]\n";

my ($game, $exe, $index) = @ARGV;
if (not defined $game or $game =~ /^(-h|--help)$/ or not defined $exe)
{
    print $usage;
    exit 0;
}

my $db_path = "$FindBin::Bin/mgl.db";

my @db = DBTools::loadDB($db_path);

eval
{
    DBTools::addGame(\@db, $game, $exe, $index);
    DBTools::saveDB(\@db, $db_path);
    1;
}
or do
{
    print "Fatal: $@";
    exit 1;
};

exit 0;

