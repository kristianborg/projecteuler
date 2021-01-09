use Math::BigInt;
for ($i = 1; $i <= 20; $i++){
	$n = 2 * $i;
	$r = $i;
	$rFac = fac($r);
	$nFac = fac($n);
	$nMinRFac = fac($n - $r);
	#print "$nFac / ($nMinRFac * $rFac)\n";
	my $result = $nFac / ($nMinRFac * $rFac);
	print "$i - $result\n";
}

sub fac {
	my $result = Math::BigInt->new($_[0])->bfac();
	#print "fac($_[0]) = $result\n";
	return $result;
}