use POSIX;

my $max = 1000000;
my @primes = getPrimeCandidates($max);
#print "primes: @primes\n";
print "numPrimes: ", scalar @primes, "\n";
my $result = 0;
foreach(@primes){
	if (length($_) == 1){
		next;
	}
	#print "processing $_\n";
	my @truncatedPrimes = getTruncations($_);
	$isOk = 1;
	foreach(@truncatedPrimes){
		if (!($_ ~~ @primes)){
			#print "$_ is NOT prime\n";
			$isOk = 0;
			last;
		} else {
			#print "$_ is prime\n";
		}
	}
	if ($isOk){
		print "$_ \n";
		$result += $_;
	}
}
print "result: $result\n";

sub getTruncations(){
	my $number = $_;
	my $length = length($number);
	my @result = ();
	for ($i = 1; $i < $length; $i++){
		my $trunc = substr($number, 0, $length - $i);
		if (!($trunc ~~ @result)){
			push(@result, $trunc);
		}
		$trunc = substr($number, $i, $length - $i);
		if (!($trunc ~~ @result)){
			push(@result, $trunc);
		}
	}
	return @result;
}

sub getPrimeCandidates(){
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
	my @illegalValues = (0, 2, 4, 5, 6, 8);
	for(my $i = 2; $i < $max; $i++){
		if($numbers[$i]){
			my $tail = substr($i, 1);
			my $containsIllegalValue = 0;
			foreach(@illegalValues){
				$illegalValue = $_;
				if (index($tail, $illegalValue) != -1){
					$containsIllegalValue = 1;
					last;
				}
			}
			# if the numbers is larger than 10 and contains a 0, 2, 4 or 5, 6 or 8, 
			# at least one of its rotations will not be prime because divisible by 2 or 5
			if (!$containsIllegalValue || $i < 10){
				push(@primes, $i);
			}
		}
	}
	
	return @primes;
}