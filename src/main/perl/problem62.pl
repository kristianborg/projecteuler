use POSIX;
use List::MoreUtils qw/ uniq /;
use strict;

my $max = 1000;
my $target = 5;
for (my $i = 1; $i <= $max; $i++){
	my $cube = $i ** 3;
	my @permutations = getPermutations($cube);
	@permutations = uniq(@permutations);
	my @crts = ();
	foreach (@permutations){
		if (substr($_, 0, 1) == 0){
			next;
		}
		my $crt = getCubicRoot($_);
		if ($crt){
			push(@crts, $crt);
		}
	}
	
	if (@crts >= 2){
		print "$i ^ 3 = $cube has cubic roots @crts\n";
	}
	if (scalar @crts >= $target){
		print "done\n";
		last;
	}
}

sub getPermutations(){
	my $number = $_[0];
	if (length $number == 1){
		return ($number);
	}
	
	my @result = ();
	for(my $i = 0; $i < length $number; $i++){
		my $subNumber = substr($number, 0, $i) . substr($number, $i + 1, length $number);
		my @subResult = getPermutations($subNumber);
		foreach(@subResult){
			push (@result, substr($number, $i, 1) . $_);
		}
	}
	
	return @result;
}

sub getCubicRoot(){
	my $crt = $_[0] ** (1/3);
	$crt = substr($crt, 0, length $crt); #silly trick to prevent rounding issues
	return $crt == ceil($crt) ? $crt : undef;
}