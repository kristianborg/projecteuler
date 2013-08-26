$maxNumber = 2000000;
@primes = (2);
$i = 2;
$sum = 2;
while($i < $maxNumber){
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
		print "$i is prime\n";
		$sum+= $i;
	}
}
print "sum: $sum\n";