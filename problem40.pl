use POSIX;
@targets = (1, 10, 100, 1000, 10000, 100000, 1000000);
$result = 1;
foreach(@targets){
	$dn = getDigit($_, 1);
	print "d$_: $dn\n";
	$result *= $dn;
}
print "result: $result\n";

sub getDigit(){
	my $n = $_[0];
	my $digits = $_[1];
	
	my $numbersWithDigits = $digits * 9 * (10 ** ($digits - 1)); 
	if ($n < 10 && $digits == 1){
		return $n;
	} elsif ($n <= $numbersWithDigits){
		my $number = floor(($n - 1)/ $digits); #we count zero-based, 1st number is number with index 0;
		my $value = (10 ** ($digits - 1)) + $number;
		my $position = $n - ($number * $digits) - 1;
		return (split("", $value))[$position];
	} else {
		return getDigit($n - $numbersWithDigits, $digits + 1);
	}
}