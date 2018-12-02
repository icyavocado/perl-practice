#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;

my $filename = 'input.txt';
my $sum = 0;
my %seen;
$seen{0} = 1;
my @list;
my $first_dup;

open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) {
  chomp; push @list, $_;
}

while (!$first_dup) {
  foreach (@list) {
    $sum += $_;
    $seen{$sum}++;
    if ($seen{$sum} && $seen{$sum} == 2) {
      print "$sum\n";
      $first_dup = 1;
      last;
    }
  }
}
