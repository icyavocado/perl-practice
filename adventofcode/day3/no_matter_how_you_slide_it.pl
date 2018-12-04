#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;
use Function::Parameters;
use Data::Dumper;
my $filename = 'input.txt';
open( my $fh, '<:encoding(UTF-8)', $filename )
  or die "Could not open file '$filename' $!";

my ( @list, %seen, $all, $non_overlap );

push @list, parseLine($_) while <$fh>;
fillmySeen($_) foreach @list;
countSeen(1);

foreach (@list) {
  $non_overlap = $_ if !is_overlap($_);
  last if $non_overlap;
}

fun parseLine($string) {
  my @numbers = split /[^0-9]+/, $string;
  shift @numbers;
  return {
    id   => shift @numbers,
    left => shift @numbers,
    top  => shift @numbers,
    wide => shift @numbers,
    tall => shift @numbers,
  };
}

fun fillmySeen($r) {
  for ( my $i = 0; $i < $r->{tall}; $i++ ) {
    for ( my $k = 0; $k < $r->{wide}; $k++ ) {
      $seen{ $r->{left} + $k }{ $r->{top} + $i }++;
    }
  }
}

fun countSeen($num) {
  for ( my $i = 0; $i <= 1000; $i++ ) {
    for ( my $k = 0; $k <= 1000; $k++ ) {
      $all++ if $seen{$i}{$k} && $seen{$i}{$k} > $num;
    }
  }
}

fun is_overlap($r) {
  my $is_overlap;
  for ( my $i = 0; $i < $r->{tall} && !$is_overlap; $i++ ) {
    for ( my $k = 0; $k < $r->{wide} && !$is_overlap; $k++ ) {
      $is_overlap++ if $seen{ $r->{left} + $k }{ $r->{top} + $i } > 1;
    }
  }
  return $is_overlap;
}

print 'Part 1: ' . $all . "\n";
print 'Part 2: ' . $non_overlap->{id} . "\n";
