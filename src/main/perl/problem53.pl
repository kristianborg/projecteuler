use Math::BigInt;

my $maxN = 100;
my $targetResult = 1000000;
my $numResults = 0;
for(my $n = 1; $n <= $maxN; $n++){
	for (my $r = 1; $r <= $n; $r++){
		$rFromN = getCombinatoric($n, $r);
		if ($rFromN > $targetResult){
			print "$r from $n: $rFromN\n";
			$numResults++;
		}
	}
}
print "result: $numResults\n";

sub getCombinatoric(){
	my $n = $_[0];
	my $r = $_[1];
	my $rFac = fac($r);
	my $nFac = fac($n);
	my $nMinRFac = fac($n - $r);
	return $nFac / ($nMinRFac * $rFac);
}

sub fac {
	return Math::BigInt->new($_[0])->bfac();
}