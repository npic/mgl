#! /usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use DBTools;

my $usage = "Usage: sort-db.pl\n";

my $help = shift @ARGV;
if (defined $help)
{
    print $usage;
    exit 0;
}

my $db_path = "$FindBin::Bin/mgl.db";

my @db = DBTools::loadDB($db_path);
@db = sort { $a->{'game'} cmp $b->{'game'} } @db;
DBTools::saveDB(\@db, $db_path);

