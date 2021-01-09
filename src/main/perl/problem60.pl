use POSIX;

my @primes = getPrimes(10000);
for (my $a = 1; $a < @primes; $a++){

	my $primeA = @primes[$a];	
	
	for (my $b = $a + 1; $b < @primes; $b++){
	
		my $primeB = @primes[$b];
		if (!isConcatenatedPrime($primeA, $primeB)){
			next;
		}
		
		for (my $c = $b + 1; $c < @primes; $c++){
		
			my $primeC = @primes[$c];
			if (!isConcatenatedPrime($primeA, $primeC)){
				next;
			}
			if (!isConcatenatedPrime($primeB, $primeC)){
				next;
			}
			
			for (my $d = $c + 1; $d < @primes; $d++){
			
				my $primeD = @primes[$d];
				if (!isConcatenatedPrime($primeA, $primeD)){
					next;
				}
				if (!isConcatenatedPrime($primeB, $primeD)){
					next;
				}
				if (!isConcatenatedPrime($primeC, $primeD)){
					next;
				}
				
				for (my $e = $d + 1; $e < @primes; $e++){
				
					my $primeE = @primes[$e];
					if (!isConcatenatedPrime($primeA, $primeE)){
						next;
					}
					if (!isConcatenatedPrime($primeB, $primeE)){
						next;
					}
					if (!isConcatenatedPrime($primeC, $primeE)){
						next;
					}
					if (!isConcatenatedPrime($primeD, $primeE)){
						next;
					}
					
					print "$primeA, $primeB, $primeC, $primeD, $primeE; sum: ", ($primeA + $primeB + $primeC + $primeD + $primeE), "\n";
					exit;
				}
			}
		}
	}
}

sub isConcatenatedPrime(){
	return isPrime($_[0] . $_[1]) && isPrime($_[1] . $_[0]);
}

sub isPrime(){
	my $target = $_[0];
	if ($target < $primes[-1]){
		return $target ~~ @primes;
	}
	if ($target > $primes[-1] ** 2){
		#since we are looking for low primes anyway, lets just pretend it is not prime
		return 0;
	}
	
	my $max = ceil(sqrt($target));
	for(my $i = 0; $i < @primes; $i++){
		my $prime = $primes[$i];
		if ($prime > $max){
			last;
		}
		if ($target % $prime == 0){
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