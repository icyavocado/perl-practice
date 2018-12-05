#!/usr/bin/perl
use strict;
use warnings;
use Timer::Runtime;
use Function::Parameters;
use DateTime;
my $filename = 'input.txt';
open( my $fh, '<:encoding(UTF-8)', $filename )
  or die "Could not open file '$filename' $!";

my ( %guards, @list );
while (<$fh>) {
  push @list, parseLine($_);
}

@list = sort { $a->{datetime} cmp $b->{datetime} } @list;

my $shift;
my $sleep;
my $wake_up;
foreach (@list) {
  $shift   = $_->{id}  if $_->{id};
  $sleep   = $_->{min} if $_->{status} eq 'falls asleep';
  $wake_up = $_->{min} if $_->{status} eq 'wakes up';
  if ( $sleep && $wake_up ) {
    $guards{$shift}{$_}++ for $sleep .. $wake_up - 1;
    $sleep   = undef;
    $wake_up = undef;
  }
}

my $found = 0;
my $idguy = 0;
foreach my $id ( keys %guards ) {
  my $guard_sleep = 0;
  for my $i ( 0 .. 59 ) {
    if ( $guards{$id}{$i} ) {
      $guard_sleep += $guards{$id}{$i};
    }
  }
  if ( $guard_sleep > $found ) {
    $found = $guard_sleep;
    $idguy = $id;
  }
}

my $most_min = 0;
my $last;
foreach my $min ( keys %{ $guards{$idguy} } ) {
  for my $i ( 0 .. 59 ) {
    if ( $guards{$idguy}{$i} && $guards{$idguy}{$i} > $most_min ) {
      $most_min = $guards{$idguy}{$i};
      $last     = $i;
    }
  }
}

foreach my $min ( keys %{ $guards{$idguy} } ) {
  for my $i ( 0 .. 59 ) {
    if ( $guards{$idguy}{$i} && $guards{$idguy}{$i} > $most_min ) {
      $most_min = $guards{$idguy}{$i};
      $last     = $i;
    }
  }
}

my $guy          = 0;
my $best_sleeper = 0;
my $best_min     = 0;
foreach my $id ( keys %guards ) {
  my $guard_sleep = 0;
  my $win         = 0;
  for my $i ( 0 .. 59 ) {
    if ( $guards{$id}{$i} && $guards{$id}{$i} > $guard_sleep ) {
      $guard_sleep = $guards{$id}{$i};
      $win         = $i;
    }
  }
  if ( $guard_sleep > $best_min ) {
    $best_min     = $guard_sleep;
    $best_sleeper = $win;
    $guy          = $id;
  }
}

print "Part 1: $idguy * $last = " . $idguy * $last . "\n";
print "Part 2: $guy * $best_sleeper = " . $guy * $best_sleeper . "\n";

fun parseLine($line) {
  my @data = split /\W+/, $line;
  shift @data;
  my $length = scalar @data;
  my $status;
  my $id;
  if ( $length > 7 ) {
    $id     = $data[ $length - 3 ];
    $status = join( ' ',
      @data[ $length - 4, $length - 3, $length - 2, $length - 1 ] );
  }
  else {
    $status = join( ' ', @data[ $length - 2, $length - 1 ] );
  }

  my $time = $data[3] ne '00' ? join( '', @data[ 3, 4 ] ) : $data[4];

  my $dt = DateTime->new(
    year   => $data[0],
    month  => $data[1],
    day    => $data[2],
    hour   => $data[3],
    minute => $data[4],
  );
  return {
    # status => $status eq 'fallsasleep' ? 2 : 1,
    datetime => $dt,
    status   => $status,
    id       => $id,
    line     => $line,
    min      => $data[4]
  };
}
