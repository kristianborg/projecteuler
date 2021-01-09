use strict;
use POSIX;

my $max = 12000;
my $minFraction = 1/3;
my $maxFraction = 1/2;
my $result = 0;
for (my $d = 1; $d <= $max; $d++){
	if ($d % 1000 == 0){
		print "processing d=$d\n";
	}
	my $minN = getClosestFraction($d, $minFraction, 1);
	my $maxN = getClosestFraction($d, $maxFraction, 0);
	for(my $n = $minN; $n <= $maxN; $n++){
		my $fraction = $n / $d;
		if ($fraction >= $maxFraction || $fraction <= $minFraction){ 
			next;
		}
		if (getGcdEuclid($d, $n) == 1){
			$result++;
		}
	}
}
print "result: $result\n";

sub getGcdEuclid(){
	my $a = $_[0];
	my $b = $_[1];
	while(1){
		my $quotient = floor($a / $b);
		my $remainder = $a % $b;
		if ($remainder == 0){
			return $b;
		}
		$a = $b;
		$b = $remainder;
	}
}

sub getClosestFraction(){
	my $d = $_[0];
	my $targetFraction = $_[1];
	my $roundUp = $_[2];
	my $result;
	if ($roundUp){
		$result = ceil($d * $targetFraction);
	} else {
		$result = floor($d * $targetFraction);
	}
	return $result < 1 ? 1 : $result;
}
