#see: http://en.wikipedia.org/wiki/Pythagorean_triple
use POSIX;
use strict;

my $max = 1500000;
print "calculating primitive pythagoran triplets\n";
my @primitiveLengths = getPrimitivePythTripletLengths($max);

my @result;
print "processing triplets\n";
for my $privitimeLength (@primitiveLengths){
	for(my $i = 1; $i <= floor($max / $privitimeLength); $i++){
		$result[$privitimeLength * $i]++;
	}
}

my $numUniq = 0;
for(my $i = 1; $i <= $max; $i++){
	# print "$i: $result[$i]\n";
	if ($result[$i] == 1){
		$numUniq++;
	}
}
print "result: $numUniq\n";



sub getPrimitivePythTripletLengths(){
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
			push(@result, $length);
			#print "$length: ($a, $b, $c); $m, $n\n";
		}
	}
	return sort(@result);
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