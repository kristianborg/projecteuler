use POSIX;
$maxDigit = 9;
my @digits = (1..$maxDigit);
my @panDigitalProducts = ();
for (my $i = 999; $i < 99999; $i++){
	if (containsDupDigits($i)){
		next;
	}
	
	for($j = 2; $j <= ceil($i / $j); $j++){
		if ($i % $j == 0){
			$k = $i / $j;
			if (isPanDigital($i, $j, $k)){
				print "$j * $k = $i\n";
				if (! ($i ~~ @panDigitalProducts)){
					push(@panDigitalProducts, $i);
				}
			}
		}
	}
}

my $sum = 0;
$sum += $_ foreach(@panDigitalProducts);
print "result: @panDigitalProducts\n";
print "sum: $sum\n";

sub isPanDigital(){
	$concat = $_[0] . $_[1] . $_[2];
	#print "$_[0] - $_[1] - $_[2]: ";
	if (length($concat) != $maxDigit){
		#print "too long/short\n";
		return 0;
	}
	
	if (index($concat, "0") != -1){
		#print "contains 0\n";
		return 0;
	}
	
	if(containsDupDigits($concat)){
		#print "contains duplicates\n";
		return 0;
	}
	
	#print "PANDIGITAL\n";
	return 1;
}

sub containsDupDigits(){
	my @digits2 = split("", $_[0]);
	#print "processing @digits\n";
	while (scalar @digits2){
		$next = pop(@digits2);
		if ($next ~~ @digits2){
			#print "dup: $next\n";
			return 1;
		}
	}
	return 0;
}