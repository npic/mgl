#! /usr/bin/perl

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

