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

my $display = 1;
while (-e "/tmp/.X11-unix/X${display}")
{
    $display ++;
}

my $wm = shift @ARGV;
if (not defined $wm)
{
    $wm = "/usr/bin/jwm";
}
system("/usr/bin/startx ${wm} -- \":${display}\" &");

# The following thing should be configured within a WM
# If you don't use a WM, you may wish to uncomment this block of code

#while (not -e "/tmp/.X11-unix/X${display}")
#{
#    sleep 1;
#}
#
#system("DISPLAY=\":${display}\" /usr/bin/nvidia-settings -l");

