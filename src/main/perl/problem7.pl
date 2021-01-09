$numPrimes = 10001;
@primes = (2);
$i = 2;
while(@primes < $numPrimes){
	$i++;
	$divides = 0;
	foreach(@primes){
		if ($i % $_ == 0){
			$divides = 1;
			last;
		}
	}
	
	if (!$divides){
		push(@primes, $i);
		print scalar @primes, "th prime:", $i, "\n";
	}
}
#print "primes: @primes";