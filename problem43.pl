my @panDigitals = getPanDigitalCandidates(1406357289, 1);
my @divisors = (2, 3, 5, 7, 11, 13, 17);
print "num pandigital candidates: ", scalar @panDigitals, "\n";
my $sum = 0;
foreach(@panDigitals){
	$result = 1;
	for($n = 0; $n < @divisors; $n++){
		$divisor = $divisors[$n];
		$dn = substr($_, $n + 1, 3);
		if ($dn % $divisor != 0){
			$result = 0;
			last;
		}
	}
	
	if ($result){
		print "adding: $_\n";
		$sum+= $_;
	}
}
print "sum: $sum\n";

sub getPanDigitalCandidates(){
	
	my $digits = $_[0];
	my $n = $_[1];
	
	my @result = ();
	for(my $i = 0; $i < length($digits); $i++){
		my $prefix = substr($digits, $i, 1);
		
		if ($n == 4 && ($prefix % 2) != 0){
			# skip because n=4 should be even
			next;
		} elsif ($n == 6 && ($prefix % 5) != 0){
			# skip because n=6 should be divisible by 5
			next;
		}
		my $subDigits = substr($digits, 0, $i) . substr($digits, $i+1);
		my @subResult = ();
		if (length($subDigits) == 0){
			push(@subResult, "");
		} else {
			@subResult = getPanDigitalCandidates($subDigits, $n + 1);
			if (!@subResult){
				#no results; skip
				return next;
			}
		}
		
		foreach(@subResult){
			push(@result, ($prefix . $_));
		}
	}
	return @result;
}