my $min = 10;
my $max = 99;
my @fractions = getFractions();
my $result = 1;
for(my $i = 0; $i < @fractions; $i++){
	my $fraction = $fractions[$i];
	@commonDigits = getCommonDigits($fraction);
		
	if ((scalar @commonDigits) > 0){
		my @fraction = @{$fraction};
		my $numerator1 = $fraction[0];
		my $denominator1 = $fraction[1];
		
		my $commonDigit = $commonDigits[0];
		my $numerator2 = $numerator1;
		$numerator2 =~ s/$commonDigit//g;
		my $denominator2 = $denominator1;
		$denominator2 =~ s/$commonDigit//g;
		if (length($numerator2) == 0 || length($denominator2) == 0){
			#print "no on account of removed all digits\n";
		} elsif ($denominator2 == 0) {
			#print "no on account of division by zero\n";
		} elsif (($numerator1 % 10) == 0 && ($denominator1 % 10) == 0){
			#print "no on account of trivial\n";
		} elsif ($numerator1 / $denominator1 == $numerator2 / $denominator2){
			print "$numerator1 / $denominator1 == $numerator2 / $denominator2 == ", $numerator1 / $denominator1, "\n";
			$result *= ($numerator1 / $denominator1);
			#print "YES\n";
		} else {
			#print "no\n";
		}
	}
}
print "result: 1/", (1/$result), "\n";

sub getCommonDigits(){
	my $fraction = $_[0];
	my @fraction = @{$fraction};
	my @numerator = split("", $fraction[0]);
	my @denomenator = split("", $fraction[1]);
	
	my @result = ();
	foreach(@numerator){
		if ($_ ~~ @denomenator){
			push(@result, $_);
		}
	}
	#print "common digits @numerator and @denomenator: @result\n";
	return @result;
}

sub getFractions(){
	my @fractions = ();
	for (my $numerator = $min; $numerator <= $max; $numerator++){
		for(my $denominator = $numerator + 1; $denominator <= $max; $denominator++){
			push(@fractions, [$numerator, $denominator]);
		}
	}
	
	#print Dumper \@fractions;
	#print "fractions: @fractions\n";
	#print "bla:", $fractions[0], "-", $fractions[1], "\n";
	return @fractions;
}