my $max = 1000000;
$result = 0;
for (my $i = 3; $i <= $max; $i++){
	my @digits = split("", $i);
	$sumFact = 0;
	$sumFact+= fact($_) foreach(@digits);
	if ($i == $sumFact){
		print "sumFact(@digits) == $sumFact\n";
		$result+= $sumFact;
	}
}
print "result: $result\n";

sub fact(){
	if ($_[0] == 0){
		return 1;
	} else {
		return $_[0] * fact($_[0] - 1);
	}
}