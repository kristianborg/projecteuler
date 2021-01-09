my $maxP = 1000;
# we assume c is the long side of the triangle
my $maxSolutions = 0;
for ($p = 1; $p <= $maxP; $p++){
	my @solutions = ();
	for (my $a = 1; $a <= $p; $a++){
		for (my $b = $a; $b <= $p; $b++){
			my $c = $p - $a - $b;
			if ($c < $a || $c < $b){
				next;
			}
			if (($a * $a + $b * $b) == $c * $c){
				my $string = "{$a, $b, $c}";
				push(@solutions, $string);
			}
		}
	}
	
	if ((scalar @solutions) > $maxSolutions){
		$maxSolutions = scalar @solutions;
		print "p = $p; numSoltions = $maxSolutions, solutions = @solutions\n";
	}
}