my $targetPow = 1000;
my $targetMod = 10000000000;
my $result = 0;
for(my $i = 1; $i <= $targetPow; $i++){
	$modPow = modPow($i, $i, $targetMod);
	$result += $modPow;
	$result %= $targetMod;
}
print "result: $result\n";

sub modPow(){
	my $base = $_[0];
	my $pow = $_[1];
	my $mod = $_[2];
	my $result = 1;
	for ($i = 0; $i < $pow; $i++){
		$result *= $pow;
		$result %= $mod;
	}
	return $result;
}