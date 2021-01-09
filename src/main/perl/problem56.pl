use Math::BigInt;
my $max = 100;
my $maxSum = 0;
for (my $i = 1; $i <= $max; $i++){
	for (my $j = 1; $j <= $max; $j++){
		my $pow = Math::BigInt->new($i)->bpow($j);
		my @digits = split("", $pow);
		my $sum = 0;
		$sum += $_ foreach(@digits);
		if ($sum > $maxSum){
			$maxSum = $sum;
			print "$i ^ $j = $pow; sum: $sum\n";
		}			
	}
}