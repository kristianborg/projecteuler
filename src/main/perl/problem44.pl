my $maxN = 100;
my @pentagonals = getPentagonals($maxN);
for (my $k = 0; $k < @pentagonals; $k++){
	for (my $j = $k + 1; $j < @pentagonals; $j++){
		my $Pj = @pentagonals[$j];
		my $Pk = @pentagonals[$k];
		my $sum = $Pj + $Pk;
		my $diff = $Pj < $Pk ? $Pk - $Pj : $Pj - $Pk;
		if ($sum ~~ @pentagonals){
			print "sum: $k, $j - ", $j - $k, "\n";
		}
		if ($diff ~~ @pentagonals){
			print "diff: $k, $j - ", $j - $k, "\n";
		}
	}
}

exit;



for (my $k = 0; $k < @pentagonals; $k++){
	for (my $j = $k - 1; $j < $k + 1; $j++){
		if ($j < 0 || $j >= scalar @pentagonals){
			next;
		}
		if ($j == $k){
			next;
		}
		
		my $Pj = @pentagonals[$j];
		my $Pk = @pentagonals[$k];
		my $sum = $Pj + $Pk;
		my $diff = $Pj < $Pk ? $Pk - $Pj : $Pj - $Pk;
		if ($sum ~~ @pentagonals){
			print "$sum is pentagonal\n";
			if ($diff ~~ @pentagonals){
				print "$diff is pentagonal as well\n";
				exit;
			} else {
				print "$diff is NOT pentagonal\n";
			}
			
		}
		
	}
}


exit;




my $maxPentagonalLength = length(@pentagonals[-1]);
my @pentagonals2 = ();
for (my $k = 0; $k < @pentagonals; $k++){
	print "$k\n";
	for (my $j = $k + 1; $j < @pentagonals; $j++){
		my $Pj = @pentagonals[$j];
		my $Pk = @pentagonals[$k];
		my $diff = zeroPrefix($Pj - $Pk, $maxPentagonalLength);
		if ($diff > 10000){
			next;
		}
		my $sum = zeroPrefix($Pj + $Pk, $maxPentagonalLength);
		push(@pentagonals2, $diff . "." . $sum);
	}
}

#print "pentagonals2, @pentagonals2\n\n";
print "about to sort ", scalar @pentagonals2, " numbers\n";
@pentagonals2 = sort(@pentagonals2);
#print "pentagonals2, @pentagonals2\n\n";

foreach(@pentagonals2){
	my $diff = substr($_, 0, index($_, "."));
	my $sum = substr($_, index($_, ".") + 1);
	if ($diff ~~ @pentagonals){
		print "$diff is pentagonal\n";
		if ($sum ~~ @pentagonals){
			print "$sum is pentagonal as well\n";
			exit;
		} else {
			print "$sum is NOT pentagonal\n";
		}
		
	}
	
}


for (my $k = 0; $k < @pentagonals; $k++){
	last;
	for (my $j = $k + 1; $j < @pentagonals; $j++){
		my $Pj = @pentagonals[$j];
		my $Pk = @pentagonals[$k];
		if (($Pj - $Pk) ~~ @pentagonals){
			print "$Pj, $Pk: $Pj - $Pk = ", $Pj - $Pk, " is pentagonal\n";
			if (($Pj + $Pk) ~~ @pentagonals){
				print "$Pj, $Pk: $Pj + $Pk = ", $Pj + $Pk, " is also pentagonal\n";
				exit;
			} else {
				print "$Pj, $Pk: $Pj + $Pk = ", $Pj + $Pk, " is NOT\n";
			}
		}
	}
}

sub zeroPrefix(){
	my $num = $_[0];
	my $totalLength = $_[1];
	my $result = "";
	for(my $i = 0; $i < $totalLength - length($num); $i++){
		$result.= "0";
	}
	return $result . $num;
}

sub getPentagonals(){
	my @result = ();
	for(my $n = 1; $n <= $_[0]; $n++){
		my $pentagonal = $n * (3 * $n - 1) / 2;
		my $previous = $result[-1];
		#print "adding $pentagonal; diff: ", $pentagonal - $previous, "\n";
		push(@result, $n * (3 * $n - 1) / 2);
	}
	return @result;
}