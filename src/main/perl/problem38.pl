my $max = 1000000;
my $maxN = 9;
my @targetDigits = (1..9);
$result = 0;
for (my $i = 1; $i <= $max; $i++){
	my $concat = "";
	for (my $j = 1; $j <= $maxN; $j++){
		$concat.= ($i * $j);
		#print "processing $i - $j - $concat\n";
		if (length $concat > scalar @targetDigits){
			#print "$i is NOK; no correct length can be formed\n";
			last;
		}
		
		if (length $concat == scalar @targetDigits){
			@digits = split("", $concat);
			my $isOk = 1;
			foreach(@targetDigits){
				if (!($_ ~~ @digits)){
					#print "$i is NOK; $_ is missing from $concat\n";
					$isOk = 0;
					last;
				}
			}
			if ($isOk){
				print "$i - $j - $concat is pandigital\n";
				if ($concat > $result){
					$result = $concat;
				}
			}
			last;
		}
	}
}
print "result: $result\n";