#! /usr/bin/perl

use strict;
use warnings;
use FindBin;

open(DESKTOP, '>', "$FindBin::Bin/MGL.desktop") or die $!;
print DESKTOP <<EOF;
#The icon was got from http://www.fatcow.com/free-icons

[Desktop Entry]
Name=My Game Library
Type=Application
Exec=$FindBin::Bin/mgl-x.pl
Path=$FindBin::Bin/
Icon=$FindBin::Bin/icon.png
Terminal=false
Encoding=UTF-8
Version=1.0

EOF
close(DESKTOP);

