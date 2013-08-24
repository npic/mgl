#! /usr/bin/perl

# Copyright 2012, 2013 Nikita Pichugin
#
# This file is part of My Game Library.
# 
# My Game Library is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# My Game Library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with My Game Library.  If not, see <http://www.gnu.org/licenses/>.

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
    elsif(DBTools::checkIndex(\@db, $_))
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

