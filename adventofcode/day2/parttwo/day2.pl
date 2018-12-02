#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;

my $filename = 'input.txt';
my (@list, @letter);
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) {
  chomp $_;
  push @list, $_;
}

while (@list) {
  my @id = split(//, shift @list);
  foreach (@list) {
    my @id_comp = split(//, $_);
    my ($count, $char) = (0, undef);
    for(my $i = 0; $i < scalar @id && $count > 1; $i++) {
      if ($id[$i] ne $id_comp[$i]) {
        $char = $i;
        $count++;
      }
    }
    splice @id, $char, 1 if $count == 1;
    print join('', @id)."\n" if $count == 1;
    last if $count == 1;
  }
}