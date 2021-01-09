my $maxNumber = 999999;
my $pow = 5;
#my $maxNumber = 99999;
#my $pow = 4;
my $result = 0;
for ($i = 1; $i <= $maxNumber; $i++){
	@digits = split("", $i);
	my $sumPow = 0;
	$sumPow += $_ ** $pow foreach(@digits);
	if ($sumPow == $i && (scalar @digits) > 1){
		print "(@digits) ^ $pow = $sumPow\n";
		$result += $i;
	}
}
print "Result: $result\n";