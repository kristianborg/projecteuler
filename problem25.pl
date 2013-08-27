use bigint;
$target = 1000;
@fibs = (1, 1);
while(1){
	$fib = $fibs[-1] + $fibs[-2];
	$length = length($fib);
	push(@fibs, $fib);
	$numFibs = scalar @fibs;
	#print "$numFibs: $fib - $length\n";
	if ($length >= $target){
		last;
	}
}
$numFibs = scalar @fibs;
print "result: $numFibs\n";