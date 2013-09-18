use POSIX;
@primes = (2);
my $i = 1;
while (1){
	$i += 2;
	if (isPrime($i)){
		push(@primes, $i);
		next;
	}
	
	my $ok = 0;
	foreach(@primes){
		$a = $i - $_;
		if (isSquare($a / 2)){
			$b = sqrt($a / 2);
			print "$i = $_ + 2 * $b^2\n";
			$ok = 1;
			last;
		}
	}
	
	if (!$ok){
		print "no match: $i\n";
		last;
	}
}

sub isSquare(){
	my $sqrt = sqrt($_[0]);
	return $sqrt == floor($sqrt);
}

sub isPrime(){
	my $n = $_[0];
	my $max = ceil(sqrt($n));
	my $result = 1;
	foreach(@primes){
		if ($_ > $max){
			last;
		}
		if ($n % $_ == 0){
			$result = 0;
			last;
		}
	}
	return $result;
}