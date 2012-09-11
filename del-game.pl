#! /usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use DBTools;

my $usage = "Usage: del-game.pl [INDEX]\n";

my $index = shift @ARGV;
if (not defined $index or $index =~ /^(-h|--help)$/)
{
    print $usage;
    exit 0;
}

my $db_path = "$FindBin::Bin/mgl.db";

my @db = DBTools::loadDB($db_path);

eval
{
    DBTools::delGame(\@db, $index);
    DBTools::saveDB(\@db, $db_path);
    1;
}
or do
{
    print "Fatal: $@";
    exit 1;
};

exit 0;
