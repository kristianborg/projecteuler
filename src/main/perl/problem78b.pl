use POSIX;
use strict;
# see http://en.wikipedia.org/wiki/Partition_%28number_theory%29
# p(0) = 1
my @summations = (1, 1, 2, 3, 5, 7);
my $modulus = 1000000;

for (my $i = 1; ; $i++){
	my $summation = getSummationEuler($i);
	if (!$summations[$i]){
		$summations[$i] = $summation;
	}
	print "$i: $summation\n";
	if ($summation == 0){
		last;
	}
}

sub getSummationEuler(){
	my $n = $_[0];
	my $result = 0;
	for(my $k = 1; $k <= $n; $k++){
		my $n1 = $n - 0.5 * $k * ((3 * $k) - 1);
		my $n2 = $n - 0.5 * $k * ((3 * $k) + 1);
		my $sign = (-1) ** ($k + 1);
		my $p1 = $n1 < 0 ? 0 : @summations[$n1];
		my $p2 = $n2 < 0 ? 0 : @summations[$n2];
		$result += ($sign * ($p1 + $p2)) % $modulus;
	}
	return $result % $modulus;
}
