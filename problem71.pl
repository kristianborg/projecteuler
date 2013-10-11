use strict;
use POSIX;

my $max = 1000000;
my $targetFraction = 3/7;
my $result = 0;
for (my $d = 1; $d <= $max; $d++){
	my $minN = getClosestFraction($d, $result, 0);
	my $maxN = getClosestFraction($d, $targetFraction, 0);
	for(my $n = $minN; $n <= $maxN; $n++){
		my $fraction = $n / $d;
		if ($fraction >= $targetFraction){ 
			last;
		}
		if (getGcdEuclid($d, $n) != 1){
			next;
		}
		if ($fraction > $result){
			$result = $fraction;
			print "new fraction $n/$d\n";
		}
	}
}

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
