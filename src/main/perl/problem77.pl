use strict;
use POSIX;

my $target = 5000;
my $maxPrime = 100;
my @primes = getPrimes($maxPrime);
my @cache;
for(my $i = 2;$i < $maxPrime; $i++){
	my $result = findPrimeSummation($i, $i - 1);
	print "$i: $result\n";
	if ($result >= $target){
		last;
	}
}

sub findPrimeSummation(){
	my $target = $_[0];
	my $maxDigit = $_[1];
	if ($target == @primes[0]){
		return 1;
	}
	if ($target < @primes[0]){
		return 0;
	}
	
	my $key = $maxPrime * $target + $maxDigit;
	if ($cache[$key]){
		return $cache[$key];
	}
	
	my $result = 0;
	for my $prime(@primes){
		if ($prime > $maxDigit || $prime > $target){
			last;
		}
		
		if($prime == $target){
			$result++;
		}
		
		$result += findPrimeSummation($target - $prime, $prime);
	}
	
	$cache[$key] = $result;
	return $result;
}

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