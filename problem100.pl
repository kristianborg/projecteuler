use POSIX;
use strict;

my $min = 10;
my $max = 1000000000000;
my $totalDiscs = 0;

my $previousRedDiscs = 1;
my $redDiscs = 6;
while ($totalDiscs < $max){
	$totalDiscs = calculateTotalDiscs($redDiscs);
	my $blueDiscs = $totalDiscs - $redDiscs;
	print "total discs: $totalDiscs; blue discs: $blueDiscs; red discs: $redDiscs\n";
	my $temp = $redDiscs;
	$redDiscs = 6 * $redDiscs - $previousRedDiscs;
	$previousRedDiscs = $temp;
	
}

sub calculateTotalDiscs(){
	my $redDiscs = $_[0];
	# we need to solve: total^2 - ((4*red + 1) * total) + 2*red^2 + 2*red = 0
	my $a = 1;
	my $b = -1 * (4 * $redDiscs + 1);
	my $c = 2 * $redDiscs ** 2 + 2 * $redDiscs;
	
	my $discriminant = sqrt(($b ** 2) - (4 * $a * $c));
	my $fRoot1 = (-$b + $discriminant ) / (2 * $a);
    my $fRoot2 = (-$b - $discriminant ) / (2 * $a);
	return $fRoot1;
}
