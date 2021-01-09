my $maxProduct = 6;
my $i = 1;
while(1){
	my $highest = $i * $maxProduct ;
	if (length($i) != length($highest)){
		$i = 10 ** length($i);
	} else {
		my @products = ();
		for(my $x = 2; $x <= $maxProduct; $x++){
			push(@products, $i * $x);
		}
		
		my @i = sort(split("", $i));
		my $found = 1;		
		foreach(@products){
			@i2 = sort(split("", $_));
			for($y = 0; $y < @i; $y++){
				if (@i[$y] != @i2[$y]){
					$found = 0;
					last;
				}
			}
			if (!$found){
				last;
			}
		}
		
		if ($found){
			print "result: $i (@products)\n";
			last;
		}
		
		$i++;
	}
}