#!/usr/bin/perl
use strict;
use warnings;
use Function::Parameters;
use List::Util qw(min);

my $filename = 'input.txt';
open( my $fh, '<:encoding(UTF-8)', $filename );

# Read the file
my $string = <$fh>;

# Alphabet a to z characters array
my @alphabet = ( 'a' .. 'z' );

# Reaction function
fun collapse( $char = undef ) {

  # Clone the string
  my $newstring = $string;

  # Remove upper character and lower character
  $newstring =~ s/($char)|\U($char)//g if $char;

  # Make list out of the string
  my @list = split( //, $newstring );

  # Loop through the list
  for ( my $i = 0; $i < scalar @list - 1; $i++ ) {

    # If lowercase is the uppercase
    if ( abs ord( $list[$i] ) - ord( $list[ $i + 1 ] ) == 32 ) {

      # Splice list at the index and the next one
      splice @list, $i, 2;

      # Move the $i back by 2
      $i = $i > 0 ? $i - 2 : -1;
    }
  }

  # Return the count of the rest of the elements
  return scalar @list;
}

print 'Part 1: ' . collapse() . "\n";
print 'Part 2: ' . min( map { collapse($_) } @alphabet ) . "\n";
