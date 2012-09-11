#! /usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use DBTools;

my $usage = "Usage: edit-game.pl (name|exe) [INDEX] [NEW VALUE]\n";

my ($what, $index, $newvalue) = @ARGV;
if (not defined $what or $what =~ /^(-h|--help)$/)
{
    print $usage;
    exit 0;
}

eval
{
    my $db_path = "$FindBin::Bin/mgl.db";
    my @db = DBTools::loadDB($db_path);

    my $key;
    if ($what eq 'name')
    {
        $key = 'game';
    }
    elsif ($what eq 'exe')
    {
        $key = 'exe';
    }
    else
    {
        die "You can edit either 'name' or 'exe'";
    }

    if (not DBTools::checkIndex(\@db, $index))
    {
        die "Bad index";
    }

    $db[$index-1]{$key} = $newvalue;
    DBTools::saveDB(\@db, $db_path);
    1;
}
or do
{
    print "Fatal: $@";
    exit 1;
};

exit 0;

