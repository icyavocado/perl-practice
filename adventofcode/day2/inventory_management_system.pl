#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;

my $filename = 'input.txt';
my (@list, $two, $three, $found);
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

while (@list && !$found) {
  my @id = split(//, shift @list);
  foreach (@list) {
    my @id_comp = split(//, $_);
    my ($count, $char) = (0, undef);
    for(my $i = 0; $i < scalar @id; $i++) {
      if ($id[$i] ne $id_comp[$i]) {
        $char = $i;
        $count++;
      }
      last if $count > 1
    }
    splice @id, $char, 1 if $count == 1;
    $found = join('', @id)."\n" if $count == 1
  }
}

print "Part 1: ".$two * $three."\n";

print "Part 2: ".$found;