#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;

my $filename = 'input.txt';
my (@list, $two, $three);
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) { 
  chomp; 
  push @list, $_;
}

foreach (@list) {
  my %seen;
  my $box_id = $_;
  foreach my $letter (split(//, $box_id)) {
    $seen{$letter}++;
  }
  foreach my $key (sort(keys %seen)) {
    if ($seen{$key} == 2) { $two++; last; }
  }
  foreach my $key (sort(keys %seen)) {
    if ($seen{$key} == 3) { $three++; last; }
  }
}

print $two * $three."\n";