use strict;
my $targetLength = 60;
my $max = 1000000;
my @facSums = ();
my @facs = (1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880);

my $result = 0;
for(my $i = 2; $i <= $max; $i++){
	my $x = $i;
	my @chain = ($x);
	while(1){
		$x = facSum($x);
		if ($x ~~ @chain){
			if (scalar @chain == $targetLength){
				$result++;
				print "found $i\n";
			}
			last;
		}
		push(@chain, $x);
	}
}
print "result: $result\n";

sub facSum(){
	my $n = $_[0];
	if ($n < @facSums && $facSums[$n]){
		return $facSums[$n];
	}
	my @digits = split("", $_[0]);
	my $result = 0;
	$result += fac($_) foreach(@digits);
	$facSums[$n] = $result;
	return $result;
}

sub fac(){
	return $facs[$_[0]];
}