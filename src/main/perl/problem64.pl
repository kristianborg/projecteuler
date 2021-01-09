use POSIX;
use strict;

my $max = 10000;
my $result = 0;
for (my $i = 2; $i <= $max; $i++){
	if (!isSquare($i)){
		my $period = getFractionPeriod($i);
		if ($period %2){
			$result++;
		}
	}
}
print "result: $result\n";

sub getFractionPeriod(){
	my $S = $_[0];
	my $sSqrt = floor(sqrt($S));;
	my $m = 0;
	my $d = 1;
	my $a = $sSqrt;
	my @fractions = ();
	while(1){
		my $mNew = $d * $a - $m;
		my $dNew = ($S - $mNew ** 2) / $d;
		my $aNew = floor(($sSqrt + $mNew) / $dNew);
		
		$m = $mNew;
		$d = $dNew;
		$a = $aNew;
		push(@fractions, $a);
		if ($a == 2 * $sSqrt){
			my $period = scalar @fractions;
			#print "sqrt($S)=[$sSqrt; (@fractions)], period=$period\n";
			return $period;
		}
	}
}

sub isSquare(){
	my $sqrt = sqrt($_[0]);
	return $sqrt == floor($sqrt);
}