use Math::BigInt;
my $iterations = 1000;
my $teller = Math::BigInt->new(1);
my $noemer = Math::BigInt->new(2);
my $result = 0;
for ($i = 2; $i <= $iterations; $i++){
	my $newNoemer = $noemer->copy();
	$newNoemer->bmul(2);
	$newNoemer->badd($teller);
	$teller = $noemer;
	$noemer = $newNoemer;
	if (length($teller + $noemer) > length($noemer)){
		print "$i: ", $teller + $noemer, " / ", $noemer, "\n";
		$result++;
	}
}
print "result: $result\n";