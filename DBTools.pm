package DBTools;

sub loadDB
{
    my $path = shift;
    my @db;

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

