my $max = 10000;
my @cubes = ();
my $target = 5;
for (my $i = 0; $i <= $max; $i++){
	$cubes[$i] = join("", sort(split("", $i ** 3)));
}

for(my $x1 = 0; $x1 < @cubes; $x1++){
	my @result = ();
	for(my $x2 = $x1; $x2 < @cubes; $x2++){
		if ($cubes[$x1] eq $cubes[$x2]){
			push(@result, $x2);
		}
	}
	
	if (@result >= $target){
		print "$x1 ^ 3 = ", $x1 ** 3, ": @result\n";
	}
}
