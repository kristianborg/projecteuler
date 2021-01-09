use POSIX;
my $maxN = 9;
for (my $i = $maxN; $i >= 1; $i--){
	my @digits = reverse(1..$i);
	my $max = join("", @digits);
	print "processing $max\n";
	
	my $sum = 0;
	$sum+= $_ foreach(@digits);
	if ($sum % 3 == 0){
		print "skipping because all its permutations will be divisible by 3\n";
		next;
	}
	my $maxPrime = ceil(sqrt($max));
	@primes = getPrimes($maxPrime);
	print "found ", scalar @primes, " primes\n";
	my @panDigitals = getPanDigitals($max);
	print "found ", scalar @panDigitals, " panDigitals\n";
	foreach(@panDigitals){
		if (isPrime($_)){
			print "$_ is prime\n";
			exit;
		}
	}
}

#digits has to be sorted high to low to have te result be sorted high to low
sub getPanDigitals(){
	my $digits = $_[0];
	if (length($digits) == 1){
		return $digits;
	}
	
	my @result = ();
	for(my $i = 0; $i < length($digits); $i++){
		my $prefix = substr($digits, $i, 1);
		my $subDigits = substr($digits, 0, $i) . substr($digits, $i+1);
		my @subResult = getPanDigitals($subDigits);
		foreach(@subResult){
			push(@result, ($prefix . $_));
		}
	}
	return @result;
}

sub isPrime(){
	my $number = $_[0];
	$result = 1;
	foreach(@primes){
		if ($_ >= $number){
			last;
		}
		if ($number % $_ == 0){
			$result = 0;
			last;
		}
	}
	return $result;
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