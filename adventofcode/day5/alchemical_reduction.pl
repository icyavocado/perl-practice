#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;
use Function::Parameters;
use List::Util qw(min);

my $filename = 'input.txt';
open( my $fh, '<:encoding(UTF-8)', $filename )
  or die "Could not open file '$filename' $!";

my $string;
my @alphabet = ( 'a' .. 'z' );
my %seen;

$string = <$fh>;

print 'Part 1: ' . collapse() . "\n";

foreach (@alphabet) {
  $seen{$_} = scalar collapse($_);
}

print 'Part 2: ' . min( values %seen ) . "\n";

fun collapse( $char = undef ) {
  my $newstring = $string;
  my @list = split( '', $newstring );

  if ($char) {
    $newstring =~ s/$char//g;
    $char = uc $char;
    $newstring =~ s/$char//g;
    @list = split( '', $newstring );
  }

  for ( my $i = 0; $i < scalar @list; $i++ ) {
    last if !$list[ $i + 1 ];
    if ( abs ord( $list[$i] ) - ord( $list[ $i + 1 ] ) == 32 ) {
      splice( @list, $i, 2 );
      $i = $i - 2;
    }
  }

  return @list;
}
