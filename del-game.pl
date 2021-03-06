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

