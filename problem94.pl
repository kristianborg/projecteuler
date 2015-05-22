use strict;
use POSIX;
 
my $maxPerimeter = 1000000000;
 
my $perimeterSum = 0;
my @pythTriplets = getPrimitivePythTriplets($maxPerimeter);
foreach my $pythTriplet (@pythTriplets){
	$perimeterSum += findTriangles($pythTriplet, $maxPerimeter);				
}
print "total perimeterSum: $perimeterSum\n";
 
 
sub findTriangles(){
	my @lengths = @{$_[0]};
	my $maxPerimeter = $_[1];
	my $combinedPerimeter=0;
	for(my $i = 1;;$i++){
		my $a = $lengths[0] * $i;
		my $b = $lengths[1] * $i;
		my $c = $lengths[2] * $i;
 
		my $perimeter = $a + $b + $c;
		if ($perimeter > $maxPerimeter){
			last;
		}
 
		if (abs($c - (2 * $b)) == 1){
			my $bottom = 2 * $b;
			$perimeter = $c + $c + $bottom;
			$combinedPerimeter += $perimeter;
			print "found [$a, $b, $c] makes triangle: [$c, $c, $bottom] with perimeter $perimeter\n";
		               
		}
 
		if (abs($c - (2 * $a)) == 1){
			my $bottom = 2 * $a;
			$perimeter = $c + $c + $bottom;
			$combinedPerimeter += $perimeter;
			print "found [$a, $b, $c] makes triangle: [$c, $c, $bottom] with perimeter $perimeter\n";
		               
		}
 
		last;
	}
	return $combinedPerimeter;
}
 
sub getPrimitivePythTriplets(){
	my $max = $_[0];
	my $maxN = floor(sqrt($max));
	my @result;
	for(my $n = 1; $n <= $maxN; $n++){
		my $nSquare = $n ** 2;
		for(my $m = $n + 1; $m <= $maxN; $m++){
	               
			# m - n should be odd
			if (($m - $n) % 2 == 0){
				next;
			}
		               
			# m and n should be coprime
			if (getGcdEuclid($m, $n) != 1){
				next;
			}
		               
			my $mSquare = $m ** 2;
			my $a = $mSquare - $nSquare;
			my $b = 2 * $m * $n;
			my $c = $mSquare + $nSquare;
			my $length = $a + $b + $c;
			if ($length > $max){
				last;
			}
 
			push(@result, [$a, $b, $c]);
		}
	}
	print "found " . scalar @result . " results\n";
	return @result;
	#return sort(@result);
}
 
sub getGcdEuclid(){
	my $a = $_[0];
	my $b = $_[1];
	while(1){
		my $quotient = floor($a / $b);
		my $remainder = $a % $b;
		if ($remainder == 0){
			return $b;
		}
		$a = $b;
		$b = $remainder;
	}
}