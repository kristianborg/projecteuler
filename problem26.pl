use Math::BigFloat;
my $max = 999;
my $precision = 3000;
my $maxLength = 0;
for(my $fraction = 2; $fraction <= $max; $fraction++){
	my $x = Math::BigFloat->new(1);
 	my $y = $x->copy()->bdiv($fraction, $precision);
	my $fractionString = substr($y, 2);
	
	#remove last few digit because of rounding
	chop($fractionString); 
	chop($fractionString); 
	chop($fractionString); 
	my $subFraction = substr($fractionString, length($fractionString) - 4);
	
	my $pos1 = index($fractionString, $subFraction);
	my $pos2 = index($fractionString, $subFraction, $pos1 + length($subFraction));
	if ($pos2 == -1){
		print "NO SOLUTION: $fraction (try increase precision)\n"; 
		next;
	}
	my $length = $pos2 - $pos1;
	if ($length == length($subFraction)){
		next;
	}
	
	my $result = substr($fractionString, $pos1, $length);
	if ($length > $maxLength){
		$maxLength = $length;
		#print "$fraction - $fractionString - length: $length - $result\n";
		print "$fraction: $length\n";
	}
}
