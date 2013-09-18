use POSIX;

my $min = 1000;
my $max = 9999;
my @primes = getPrimes($max);

for (my $i1 = 0; $i1 < @primes; $i1++){
	my $prime1 = @primes[$i1];
	if ($prime1 < $min){
		next;
	}
	
	for (my $i2 = $i1 + 1; $i2 < @primes; $i2++){
		my $prime2 = @primes[$i2];
		my $diff = $prime2 - $prime1;
		my $prime3 = $prime2 + $diff;
		if ($prime3 > $max){
			last;
		}
		
		if ($prime3 ~~ @primes){
			
			if (arePermutations($prime1, $prime2, $prime3)){
				print "$prime1, $prime2, $prime3 are all prime and permutations of eachother (diff: $diff)\n";
			}
		}
	}
	
}

sub arePermutations(){
	my @digits1 = sort(split("", $_[0]));
	my @digits2 = sort(split("", $_[1]));
	my @digits3 = sort(split("", $_[2]));
	
	for (my $i = 0; $i < @digits1; $i++){
		if (@digits1[$i] != @digits2[$i] || @digits2[$i] != @digits3[$i]){
			return 0;
		}
	}
	return 1;
}

sub getPrimes(){
	my $max = $_[0];
	my @numbers = (0, 0);
	for(my $i = 2; $i < $max; $i++){
		$numbers[$i] = 1;
	}
	
	for(my $i = 2; $i < ceil($max/2); $i++){
		if (!$numbers[$i]){
			next;
		}
		
		for(my $j = $i * 2; $j <= $max; $j += $i){
			$numbers[$j] = 0;
		}
	}
	
	my @primes = ();
	for(my $i = 2; $i < $max; $i++){
		if($numbers[$i]){
			push(@primes, $i);
		}
	}
	
	return @primes;
}