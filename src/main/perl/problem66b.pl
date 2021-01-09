use Math::BigInt;
use strict;
use POSIX;

my $max = 1000;

my $highestX = 0;
my $result = 0;
for(my $d = 1; $d <= $max; $d++){
	if (isSquare($d)){
		next;
	}
	my $x = solveByChakravalaMethod($d);
	if ($x > $highestX){
		$highestX = $x;
		$result = $d;
		print "$d: $x HIGHEST!\n";
	} else {
		print "$d: $x\n";
	}
}
print "result: d=$result, x=$highestX\n";

# see http://en.wikipedia.org/wiki/Chakravala_method
sub solveByChakravalaMethod(){
	my $d = Math::BigInt->new($_[0]);
	my @xAndY = getOptimalXandY($d);
	my $x = Math::BigInt->new(@xAndY[0]);
	my $y = Math::BigInt->new(@xAndY[1]);
	my $k = $x->copy()->bpow(2)->bsub( $d->copy()->bmul($y->copy()->bpow(2))); # k = x^2 - $d*$y^2;
	if ($k == 1){
		return $x;
	}
	
	while(1){
		my $m = getOptimalM($x, $y, $k, $d);
		
		#calculate new values: x=(xm+dy)/|k|; y=(x+ym)/|k|; k=(m^2-d)/k
		my $kAbs = $k->copy()->babs();;
		my $newX=$x->copy()->bmul($m)->badd($d->copy()->bmul($y))->bdiv($kAbs);
		my $newY=$y->bmul($m)->badd($x)->bdiv($kAbs);
		my $newK=$m->bpow(2)->bsub($d)->bdiv($k);
		$x = $newX;
		$y = $newY;
		$k = $newK;
		
		if ($k == 1 || $k == -1 || $k == 2 || $k == -2){
			return solveByBrahmagupta($x, $y, $k, $d);
		}
	}
}

# find m such that |k| divides x+ym and |m^2-d| is minimal
sub getOptimalM(){
	my $x = $_[0];
	my $y = $_[1];
	my $k = $_[2];
	my $d = $_[3];
	
	# find 20 candidates which |k| divides x+ym);
	my @mCandidates = ();
	my $mCandidate = 1;
	while(1){
		if (($x + $y * $mCandidate) % $k == 0){
			push(@mCandidates, $mCandidate);
		}
		
		if (@mCandidates == 20){
			last;
		}
		$mCandidate++;
	}
	
	#select the one for which |m^2-d| is minimal
	my $minValue = undef;
	my $m = 0;
	for my $mCandidate (@mCandidates){
		my $value = abs($mCandidate ** 2 - $d);
		if ($minValue == undef || $value < $minValue){
			$minValue = $value;
			$m = Math::BigInt->new($mCandidate);
		}
	}
	return $m;
}

# find x and y such that $x^2 - $d*$y^2 =~ 0
# in other words, such that $x^2 =~ $d*$y^2;
sub getOptimalXandY(){
	my $d = $_[0];
	my $minK = 9999;
	my @result = ();
	for(my $x = 1; $x < 100; $x++){
		my $y = floor(sqrt(($x ** 2) / $d));
		if ($y == 0){
			next;
		}
		my $k = abs($x ** 2 - $d * $y ** 2);
		if ($k < $minK && $y != 0){
			$minK = $k;
			@result = ($x, $y);
		}
		if ($k == 1){
			last;
		}
	}
	
	return @result;
}

sub solveByBrahmagupta{
	my $x = $_[1];
	my $y = $_[0];
	my $k = $_[2];
	my $d = $_[3];
	
	my $actualX = 0;
	my $actualY = 0;
	if ($k == 1){
		$actualX = $x;
		$actualY = $y;
	} elsif($k == -1){
		$actualX = 2 * $x * $y;
		$actualY = $y ** 2 + $d * $x ** 2;
	} elsif($k == 2){
		$actualX = $x * $y;
		$actualY = $y ** 2 - 1;
	} elsif($k == -2){
		$actualX = $x * $y;
		$actualY = $y ** 2 + 1;
	} else {
		print "invalid value for K: $k\n";
		exit;
	}
	
	return $actualY;
}


sub isSquare(){
	my $sqrt = sqrt($_[0]);
	return $sqrt == floor($sqrt);
}