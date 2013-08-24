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

my $usage = "Usage: gen-desktop.pl [X CLIENT]\n";
my $wm = shift @ARGV || "";
if ($wm =~ /^(-h|--help)$/)
{
    print $usage;
    exit 0;
}
open(DESKTOP, '>', "$FindBin::Bin/MGL.desktop") or die $!;
print DESKTOP <<EOF;
#The icon was got from http://www.fatcow.com/free-icons

[Desktop Entry]
Name=My Game Library
Type=Application
Exec=$FindBin::Bin/mgl-x.pl $wm
Path=$FindBin::Bin/
Icon=$FindBin::Bin/icon.png
Terminal=false
Encoding=UTF-8
Version=1.0

EOF
close(DESKTOP);

