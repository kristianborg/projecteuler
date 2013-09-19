use POSIX;

my $max = 1000000;
@primes = getPrimes($max);
print "found ", scalar @primes, " primes\n";
my @result = ();

foreach(@primes){
	#print "processing $_\n";
	@digits = getConsecutivePrimeSum($_);
	if (@digits > @result){
		@result = @digits;
		print "$_: length ", scalar @digits, "; initial digit: ", @result[0], "\n";
	}
}

sub getConsecutivePrimeSum(){
	my $n = $_[0];
	for(my $i = 0; $i < 10; $i++){
		if ($primes[$i] == $n){
			last;
		}
		my @result = ();
		my $sum = 0;
		for(my $j = $i; $j < @primes; $j++){
			my $prime = $primes[$j];
			if ($prime == $n){
				last;
			}
			$sum += $prime;
			push(@result, $prime);
			if ($sum == $n){
				return @result;
			}
			if ($sum > $n){
				last;
			}
		}
	}
	
	return ();
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