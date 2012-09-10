#! /usr/bin/perl

use strict;
use warnings;
use File::Find;
use FindBin;
use lib "$FindBin::Bin";
use DBTools;

sub wanted
{
    if (/^desura_launch_Play\.sh$/)
    {
        my $game = $File::Find::dir;
        $game =~ s|^.*/(.*?)$|$1|;
        $game =~ s|-| |g;

        my $exe = $File::Find::name;

        DBTools::addGame(\@main::db, $game, $exe, @main::db);
    }
}

my $usage = "Usage: import-desura.pl [DESURA INSTALL DIR]\n";

my $desura_path = shift @ARGV;
if (not defined $desura_path or $desura_path =~ /^(-h|--help)$/)
{
    print $usage;
    exit 0;
}
$desura_path .= '/' if $desura_path !~ /\/$/;
$desura_path .= 'common/';

my $db_path = "$FindBin::Bin/mgl.db";

our @db = DBTools::loadDB($db_path);
find(\&wanted, ($desura_path));
DBTools::saveDB(\@db, $db_path);

