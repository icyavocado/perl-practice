#! /usr/bin/perl
use Timer::Runtime;

open FILEHANDLE, 'input.txt' or die $!;
$_ = do { local $/; <FILEHANDLE> };

my @s = map { join "", sort split "" } split "\n";
my $part1 = (grep { m/(?:^|(.)(?!\1))(.)\2(?!\2)/   } @s) *
            (grep { m/(?:^|(.)(?!\1))(.)\2\2(?!\2)/ } @s);
my $part2 = s/.*?\b(\S*)\S(\S*)\b.*?\1\S\2.*/$1$2/sr;
print "Part 1: $part1\n";
print "Part 2: $part2\n";

# https://www.reddit.com/r/adventofcode/comments/a2aimr/2018_day_2_solutions/eawmvjq/