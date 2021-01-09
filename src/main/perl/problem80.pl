use POSIX;
use strict;
use Math::BigFloat;

Math::BigFloat->accuracy(110);

my $result = 0;
for (my $i = 2; $i <= 100; $i++){
	if (isSquare($i)){
		print "skipping $i\n";
	} else {
		my $sqrt = doSqrt($i);
		my $digitalSum = findDigitalSum($sqrt);
		print "result for $i: $digitalSum\n";
		$result += $digitalSum;
	}
}
print "result: $result\n";

sub isSquare(){
	return index(sqrt($_[0]), ".") == -1;
}

sub doSqrt(){
	my $sqrt = Math::BigFloat->new($_[0])->bsqrt();;
	return $sqrt;
}

sub findDigitalSum(){
	my $sqrt = $_[0];
	$sqrt =~ s/\.//g;
	
	my @digits = split("", $sqrt);
	my $result = 0;
	for(my $i = 0; $i < 100; $i++){
		$result += @digits[$i];
	}
	return $result;
}