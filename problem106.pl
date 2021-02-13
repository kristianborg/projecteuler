use strict;
use POSIX;
use bigint;
use Math::BigFloat;

solve(4000000);




# the number of solutions only dependse on the number of divisors of n.
# the number of divisors of a number only depends on the exponents of its prime divisors
# that is: if a number is prime1^a * prime2^b * prime3^c, the number of divisors is solely
# depending on the values of a, b and c.
# so we only try unique combinations of number of different prime divisors.
sub solve(){
	my $target = $_[0];
	my $numDivisors = ceil(doLog($target, 2));
	print "nd: $numDivisors\n";
	my @primes = getPrimes($numDivisors);
	my @numbers = ();
	for (my $i = 1; $i <= $numDivisors; $i++){
		my @sumSets = getSumSets($i, 1);
		my @subNumbers = getNumbers(\@primes, \@sumSets);
		push (@numbers, @subNumbers);
	}
	my @numbers = sort {$a <=> $b} @numbers;
	print "processing the following numbers: @numbers\n";

	my $highestResult = 0;
	foreach my $number (@numbers){
		my $numSolutions = getNumDivisors($number, \@primes);
		if ($numSolutions > $highestResult){
			print "$number has $numSolutions solutions\n";
			$highestResult = $numSolutions;
			if ($numSolutions >= $target){
				last;
			}
		}
	}
}

sub getNumbers(){
	my @primes = @{$_[0]};
	my @sumSets = @{$_[1]};
	
	#print "primes: @primes\n";
	
	my @numbers = ();
	foreach my $sumSet (@sumSets){
		my @sumSet = @{$sumSet};
		#print "processing sumset @sumSet\n";
		my $number = 1;
		my $primePtr = 0;
		foreach my $occurence (@sumSet){
			my $prime = $primes[$primePtr];
			#print "multiplying $number with $prime ^ $occurence\n";
			$number *= $prime ** $occurence;
			$primePtr++;
		}
		push(@numbers, $number);
		#print "@sumSet results in $number\n";
	}
	#print "numbers: @numbers\n";
	return @numbers;
}

sub getSumSets(){
	my $sumValue = $_[0];
	my $minValue = $_[1];
	my @result = ();
	if ($sumValue == 0 || $sumValue < $minValue){
		return @result;
	}
	
	push (@result, [$sumValue]);
	for (my $i = $minValue; $i < $sumValue; $i++){
		my @subResults = getSumSets($sumValue - $i, $i);
		foreach my $subResult (@subResults){
			my @subResult = @{$subResult};
			push(@subResult, $i);
			push(@result, \@subResult);
		}
	}
	return @result;
}

sub getPrimes(){
	my $numPrimes = $_[0];
	my $max = 100;
	my @numbers = (0, 0);
	for(my $i = 2; $i <= $max; $i++){
		$numbers[$i] = 1;
	}
	
	for(my $i = 2; $i <= ceil(sqrt($max)); $i++){
		if (!$numbers[$i]){
			next;
		}
		
		for(my $j = $i * 2; $j <= $max; $j += $i){
			$numbers[$j] = 0;
		}
	}
	
	my @primes = ();
	for(my $i = 2; $i <= $max; $i++){
		if($numbers[$i]){
			push(@primes, $i);
		}
		if (scalar @primes == $numPrimes){
			last;
		}
	}
	
	print "$numPrimes primes: @primes\n";
	return @primes;
}

sub getNumDivisors(){
	my $num = $_[0];
	my @primes = @{$_[1]};
	
	my $result = 1;
	foreach my $prime (@primes){
		my $divisorOccurence = 0;
		while ($num % $prime == 0){
			$num /= $prime;
			$divisorOccurence++;
		}
		$result *= ($divisorOccurence + 1);
	}

	return $result;
}

sub doLog(){
	my $num = Math::BigFloat->new($_[0]);
	$num->blog($_[1]);
	return $num;
}