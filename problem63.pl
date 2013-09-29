use POSIX;
my $pow = 1;
my $numResults = 0;
while(1){
	my $min = ceil( (10 ** ($pow - 1)) ** (1/$pow));
	my $max = 9;
	if ($min == 10){
		last;
	}
	
	print "proccessing $pow; min: $min; max: $max; adding: ", $max - $min + 1, "\n";
	$numResults += $max - $min + 1;
	$pow++;
}
print "result: $numResults\n";