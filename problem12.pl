$max = 10000;
$sum = 0;
$maxFoundDivisors = 0;
$targetDivisors = 500;
for($i = 1; $i <= $max; $i++){
	$sum += $i;
	$numDivisors = 0;
	for ($j = 1; $j <= $sum; $j++){
		if ($sum % $j == 0){
			$numDivisors++;
		}
	}
	
	if ($numDivisors > $maxFoundDivisors){
		print "$i: $sum = $numDivisors\n";
		$maxFoundDivisors = $numDivisors;
	}
	
	if ($maxFoundDivisors >= $targetDivisors){
		last;
	}
}
