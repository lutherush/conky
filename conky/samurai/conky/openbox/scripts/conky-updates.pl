#!/usr/bin/perl
use strict;
use warnings;
my $n = (`aptitude search "~U" | wc -l`);
chomp ($n);
if ($n == 0)
{
     print "Actualizado"
}
else
{
print "$n Disponibles "
}
