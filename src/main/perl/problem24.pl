use Math::BigInt;
use POSIX;
#1  0123
#2  0132
#3  0213
#4  0231
#5  0312
#6  0321
#7  1023
#8  1032
#9  1203
#10 1230
#11 1302
#12 1320
#13 2013
#14 2031
#15 2103
#16 2130
#17 2301
#18 2310

my $numDigits = 10;
my $targetPermutation = 1000000;
my @digits = (0..$numDigits-1);

#we start counting at 0, so substract 1
my $result = getNthPermutation(\@digits, $targetPermutation - 1, "");
print "the $targetPermutation th permutation of all sorted $numDigits-digit strings is $result\n";

#assumes @targetDigits is sorted
sub getNthPermutation(){
	my $targetDigits= $_[0];
	my @targetDigits = @{$targetDigits};
	my $target = $_[1];
	my $subSolution = $_[2];
	my $numDigits = scalar @targetDigits;

	if (scalar @targetDigits == 1){
		return $subSolution. pop(@targetDigits);
	}
	
	if ($target > fac($numDigits)){
		print "no solution\n";
		exit 1;
	}
	
	my $next = floor($target / fac($numDigits - 1));
	$subSolution .= @targetDigits[$next];
	
	#remove $next from result;
	splice(@targetDigits, $next, 1);
	return getNthPermutation(\@targetDigits, $target - $next * fac($numDigits - 1), $subSolution);
}

sub fac(){
	return Math::BigInt->new($_[0])->bfac();
}