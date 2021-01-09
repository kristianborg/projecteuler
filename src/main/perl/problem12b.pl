$max = 100000;
$sum = 0;
$maxFoundDivisors = 0;
$targetDivisors = 500;
for($i = 1; $i <= $max; $i++){
	#print "$i: ";
	@divisors = ();
	$sum += $i;
	for ($j = 1; $j <= sqrt($sum); $j++){
		if ($sum % $j == 0){
			#print "$j, ", $sum / $j, ", ";
			push(@divisors, $j);
			push(@divisors, $sum / $j);
		}
	}
	
	#print " - ", $#divisors + 1, "\n";
	
	if ($#divisors + 1 > $maxFoundDivisors){
		$maxFoundDivisors = $#divisors + 1;
		print "NEW: $i: $sum = $maxFoundDivisors\n";
		#print "list, ", sort @divisors, "\n";
	}
	
	if ($maxFoundDivisors >= $targetDivisors){
		last;
	}
}
