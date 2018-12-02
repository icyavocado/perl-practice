#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;

my $filename = 'input.txt';
my (@list, $sum, $sum2, $found, %seen);

open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) { chomp; push @list, $_; }

$sum += $_ foreach @list;

while (!$found) {
  foreach (@list) {
    $sum2 += $_;
    $seen{$sum2}++;
    if ($seen{$sum2} && $seen{$sum2} == 2) {
      $found = $sum2;
      last;
    }
  }
}

print "Part 1: ".$sum."\n";
print "Part 2: ".$found."\n";