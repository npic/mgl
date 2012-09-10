#! /usr/bin/perl

use strict;
use warnings;
use FindBin;

my ($fontW, $fontH) = (7, 14);
my ($screenW, $screenH);

foreach my $line (`/usr/bin/xdpyinfo`)
{
    if ($line =~ /^\s*dimensions:\s*(\d+)x(\d+)/)
    {
        my $scrollbarW = 12;
        $screenW = int( ($1 - $scrollbarW) / $fontW );
        $screenH = int( $2 / $fontH );
        last;
    }
}

my $term = "/usr/bin/urxvt +hold -sr -fn ${fontW}x${fontH} -geometry ${screenW}x${screenH}+0+0 -fg gray50 -bg black -e";

my $mglpath = "$FindBin::Bin/mgl.pl";

my $display = 1;
while (-e "/tmp/.X11-unix/X${display}")
{
    $display ++;
}

system("/usr/bin/startx ${term} \"${mglpath}\" -- \":${display}\" &");

while (not -e "/tmp/.X11-unix/X${display}")
{
    sleep 1;
}

system("DISPLAY=\":${display}\" /usr/bin/nvidia-settings -l");

