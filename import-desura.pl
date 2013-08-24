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

