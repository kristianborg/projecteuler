use POSIX;
use strict;

my $max = 10000;
my $result = 0;
for (my $i = 2; $i <= $max; $i++){
	if (!isSquare($i)){
		my $period = getFractionPeriod($i);
		if ($period %2 == 1){
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
	my @fractions = ($a);
	my @ids = ($m . "-" . $d . "-" . $a);
	#print "m=$m, d=$d, a=$a\n";
	while(1){
		my $mNew = $d * $a - $m;
		my $dNew = ($S - $mNew ** 2) / $d;
		my $aNew = floor(($sSqrt + $mNew) / $dNew);
		
		$m = $mNew;
		$d = $dNew;
		$a = $aNew;
		my $id = $m . "-" . $d . "-" . $a;
		#print "m=$m, d=$d, a=$a\n";
		if ($id ~~ @ids){
			my @head = ();
			my @tail = ();
			for(my $i = 0; $i < @ids; $i++){
				if($ids[$i] == $id || scalar(@tail)){
					push(@tail, $fractions[$i]);
				} else {
					push(@head, $fractions[$i]);
				}
			}
			#print "sqrt($S)=[@head; (@tail)], period=",scalar @tail, "\n";
			return scalar @tail;
		}
		push(@fractions, $a);
		push(@ids, $id);
	}
}

sub isSquare(){
	my $sqrt = sqrt($_[0]);
	return $sqrt == floor($sqrt);
}