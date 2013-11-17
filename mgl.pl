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

sub help
{
    print "My Game Library Command List:\n";
    print "\n";
    print "Any natural number ... run the game with the specified index\n";
    print "Empty string ......... do nothing\n";
    print "reload or r .......... reload the database\n";
    print "unselect, undo or u .. reset the selection\n";
    print "help, h or ? ......... print this help\n";
    print "exit, quit, x or q ... quit My Game Library\n";
    print "Anything else ........ try to match titles to the specified regex\n";
    print "\n";
    print "Note that My Game Library strips all spaces at the beginning\n";
    print "and at the end of the input string\n";
    print "\n";
    print "Press Enter to continue...\n";
    <STDIN>;
    return;
}

sub printPS2
{
    print (exists $ENV{'PS2'} ? $ENV{'PS2'} : '> ');
    return;
}

my $db_path = "$FindBin::Bin/mgl.db";
my @db = DBTools::loadDB($db_path);
my @selection = @db;

DBTools::printDB(\@selection);
printPS2();

while(<STDIN>)
{
    chomp;
    s/^\s+//;
    s/\s+$//;
    if(/^(exit|quit|x|q)$/)
    {
        last;
    }
    if(/^(help|h|\?)$/)
    {
        help();
    }
    elsif(/^(reload|r)$/)
    {
        @db = DBTools::loadDB($db_path);
        @selection = @db;
    }
    elsif(/^(unselect|undo|u)$/)
    {
        @selection = @db;
    }
    elsif(/^$/)
    {
    }
    elsif(DBTools::checkIndex(\@selection, $_))
    {
        system($selection[$_-1]{'exe'});
    }
    else
    {
        my @new_selection;
        my $new_selection_length = 0;
        foreach my $record (@selection)
        {
            my $regex_check = eval { $record->{'game'} =~ /$_/i };
            if ($regex_check)
            {
                push(@new_selection, $record);
                $new_selection_length ++;
            }
        }
        if ($new_selection_length == 0)
        {
            print "Nothing matched\n";
        }
        elsif ($new_selection_length == 1)
        {
            system($new_selection[0]{'exe'});
        }
        else
        {
            @selection = @new_selection;
        }
    }

    DBTools::printDB(\@selection);
    printPS2();
}

