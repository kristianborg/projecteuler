use POSIX;

@primes = getPrimes(1000);
$numDiagonals = 1;
$numDiagonalPrimes = 0;
$sideLength = 1;
$lastNumber = 1;
$targetPercentage = 10;
while (1){
	$sideLength += 2;
	$numDiagonals += 4;
	
	#top right:
	$lastNumber += $sideLength - 1;
	if (isPrime($lastNumber)){
		$numDiagonalPrimes++;
	}
	
	#top left:
	$lastNumber += $sideLength - 1;
	if (isPrime($lastNumber)){
		$numDiagonalPrimes++;
	}
	
	#bottom left:
	$lastNumber += $sideLength - 1;
	if (isPrime($lastNumber)){
		$numDiagonalPrimes++;
	}
	
	#bottom right:
	$lastNumber += $sideLength - 1;
	if (isPrime($lastNumber)){
		$numDiagonalPrimes++;
	}
	
	my $percentage = $numDiagonalPrimes * 100 / $numDiagonals;
	my $roundedRercentage = (substr($percentage, 0, 5));
	print "len: $sideLength; diags: $numDiagonals; primes: $numDiagonalPrimes; perct: $roundedRercentage; lastNumber: $lastNumber\n";
	if ($percentage <= $targetPercentage){
		print "result: $sideLength\n";
		last;
	}
}

sub isPrime(){
	my $target = $_[0];
	my $max = ceil(sqrt($target));
	if ($max > @primes[-1]){
		# double numer of calculated primes
		my $numPrimes = 2 * @primes[-1];
		print "updating primes; looking for primes untill $numPrimes\n";
		@primes = getPrimes($numPrimes);
	}
	
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
	
	my @primes2 = ();
	for(my $i = 2; $i < $max; $i++){
		if($numbers[$i]){
			push(@primes2, $i);
		}
	}
	
	return @primes2;
}