$maxNumber = 2000000;
@primes = (0..$maxNumber);
$count = 0;
foreach(@primes){
	$target = $_;
	$count++;
	if ($count%1000 == 0){
		print "processing $count\n";
	}
	if ($target != 0 && $target != 1){
		if ($target != undef){
			for($i = $target * 2; $i <= $maxNumber; $i += $target){
				$primes[$i] = undef;
			}
		}
	}
}

print "primes: @primes\n";
print "calculating sum\n";
$sum = -1;
foreach(@primes){
	if ($_ != undef){
		$sum+= $_;
	}
}
print "sum: $sum";