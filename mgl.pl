#! /usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use DBTools;

sub printPS2
{
    print (exists $ENV{'PS2'} ? $ENV{'PS2'} : '> ');
    return;
}

my $db_path = "$FindBin::Bin/mgl.db";
my @db = DBTools::loadDB($db_path);

DBTools::printDB(\@db);
printPS2();

while(<STDIN>)
{
    chomp;
    s/\s//g;
    if(/^(exit|quit|x|q)$/)
    {
        last;
    }
    elsif(/^(reload|r)$/)
    {
        @db = DBTools::loadDB($db_path);
    }
    elsif(/^$/)
    {
    }
    elsif(/^[1-9]\d*$/ and defined $db[$_-1])
    {
        system($db[$_-1]{'exe'});
    }
    else
    {
        my $matched_count = 0;
        my $matched_game;
        foreach my $record (@db)
        {
            if ($record->{'game'} =~ /$_/i)
            {
                $matched_count ++;
                $matched_game = $record->{'exe'};
                last if $matched_count > 1;
            }
        }
        if ($matched_count == 0)
        {
            print "Nothing matched\n";
        }
        elsif ($matched_count == 1)
        {
            system($matched_game);
        }
        else
        {
            print "Ambiguous input\n";
        }
    }

    DBTools::printDB(\@db);
    printPS2();
}

