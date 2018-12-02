#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;

my $filename = 'input.txt';
my $sum;

open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) {
  chomp;
  $sum += $_
}
print $sum;