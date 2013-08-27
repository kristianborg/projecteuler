use POSIX;
my $maxVal = 999;
my $maxPrime = doQuadratic(100, $maxVal, $maxVal);
@primes = getPrimes($maxPrime);
my $maxLength = 0;
for(my $b = 1; $b <= $maxVal; $b++){
	#print "processing b= $b\n";
	# a has to be prime
	if (!isPrime($b)){
		next;
	}
	
	for(my $a = -$maxVal; $a <= $maxVal; $a++){
		my $n = 0;
		while(1){
			if (isPrime(doQuadratic($n, $a, $b))){
				$n++;
			} else {
				last;
			}
		}
		if ($n > $maxLength){
			$maxLength = $n;
			print "a = $a, b = $b, max n: $n\n";
		}
	}
}

sub doQuadratic(){
	my $n = $_[0];
	my $a = $_[1];
	my $b = $_[2];
	
	return ($n ** 2) + ($n * $a) + $b;
}

sub isPrime(){
	return $_[0] ~~ @primes;
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
		
		push(@primes, $i);
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