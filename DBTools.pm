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

package DBTools;

sub loadDB
{
    my $path = shift;
    my @db;

    if (not -e $path)
    {
        my @emptydb = ();
        saveDB(\@emptydb, $path);
    }
    open(DB, '<', $path) or die $!;
    while(<DB>)
    {
        chomp;
        my ($game, $exe) = split(/;/, $_, 2);
        push(@db, ( {'game' => $game, 'exe' => $exe} ));
    }
    close(DB);

    return @db;
}

sub saveDB
{
    my ($dbref, $path) = @_;

    open(DB, '>', $path) or die $!;
    foreach my $record (@{$dbref})
    {
        print DB $record->{'game'}, ';', $record->{'exe'}, "\n";
    }
    close(DB);
    return;
}

sub printDB
{
    my $dbref = shift;

    my $i = 1;
    foreach my $record (@{$dbref})
    {
        print "[$i] ", $record->{'game'}, "\n";
        $i ++;
    }
    return;
}

sub checkIndex
{
    my ($dbref, $index, $upperBoundPlus1) = @_;

    my $upperBound = scalar @{$dbref};
    $upperBound++ if $upperBoundPlus1;

    return ($index =~ /^[1-9]\d*$/ and $index <= $upperBound);
}

sub addGame
{
    my ($dbref, $game, $exe, $index) = @_;
    $index = @{$dbref}+1 if not defined $index;

    if (checkIndex($dbref, $index, 1))
    {
        splice(@{$dbref}, $index-1, 0, ({'game' => $game, 'exe' => $exe}));
    }
    else
    {
        die "Bad index";
    }
    return;
}

sub delGame
{
    my ($dbref, $index) = @_;
    if (checkIndex($dbref, $index))
    {
        splice(@{$dbref}, $index-1, 1);
    }
    else
    {
        die "Bad index";
    }
    return;
}

1;

