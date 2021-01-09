use POSIX;

#$max = 600851475143 ;
$max = 100000;
#$max = 10;
@primes = (2);
for($i = 3; $i <= $max; $i++){
	#print "trying $i\n";
	$divides = 0;
	foreach(@primes){
		if (floor($i / $_) == $i / $_){
			$divides = 1;
			last;
		}
	}
	
	if (!$divides){
		push(@primes, $i);
	}
}

#print "primes until $max: @primes\n";

$result = 0;
$target = 600851475143;
print "target $target\n";
for(@primes){
	while (true) {
		if (floor($target / $_) == $target / $_){
			print "prime factor: $_\n";
			$target /= $_;
		} else {
			last;
		}
	}
}
print "left-over: $target\n";