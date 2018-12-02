#!/usr/bin/perl
use strict;
use warnings;

my $filename = 'input.txt';
my (@list, $two, $three);
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) { 
  chomp; 
  push @list, $_;
}

foreach (@list) {
  my %seen;
  $seen{$_}++ foreach split(//, $_);
  foreach (keys %seen) {
    if ($seen{$_} == 2) { $two++; last; }
  }
  foreach (keys %seen) {
    if ($seen{$_} == 3) { $three++; last; }
  }
}

print $two * $three."\n";