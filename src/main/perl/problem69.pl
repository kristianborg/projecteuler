use POSIX;
use strict;

my $target = 1000000;
my @primes = getPrimes(sqrt($target));

my $result = 1;
for my $prime (@primes){
	if ($result * $prime > $target){
		last;
	}
	$result *= $prime;
}
print "result: $result\n";

sub getPrimes(){
	my $max = $_[0];
	my @numbers = (0, 0);
	for(my $i = 2; $i <= $max; $i++){
		$numbers[$i] = 1;
	}
	
	for(my $i = 2; $i <= ceil($max/2); $i++){
		if (!$numbers[$i]){
			next;
		}
		
		push(@primes, $i);
		for(my $j = $i * 2; $j <= $max; $j += $i){
			$numbers[$j] = 0;
		}
	}
	
	my @primes = ();
	for(my $i = 2; $i <= $max; $i++){
		if($numbers[$i]){
			push(@primes, $i);
		}
	}
	
	return @primes;
}