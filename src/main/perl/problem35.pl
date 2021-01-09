use POSIX;
my $max = 1000000;
my @primes = getPrimeCandidates($max);
my $result = 0;
print "prime candidates: @primes\n";
print "number of primecandidates: ", scalar @primes, "\n";
foreach(@primes){
	my $prime = $_;
	my @rotations = getRotations($prime);
	$isCircular = 1;
	foreach(@rotations){
		$rotation = $_;
		if (!($rotation ~~ @primes)){
			$isCircular = 0;
			last;
		}
	}
	if ($isCircular){
		$result++;
		print "$prime is curcular: @rotations\n";
	}
}
print "result: $result\n";


sub getRotations(){
	$number = $_[0];
	$length = length($number);
	@result = ();
	for(my $i = 0; $i < $length; $i++){
		push(@result, substr($number . $number, $i, $length));
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
			$containsIllegalValue = 0;
			foreach(@illegalValues){
				$illegalValue = $_;
				if (index($i, $illegalValue) != -1){
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