#old: 5000 - 2035227 - 20s

use POSIX;
my $max = 28123 ;
#my $max = 5000 ;
@abundantNumbers = getAbundantNumbers($max);
print "abundantNumbers: @abundantNumbers\n";
print "found ", scalar @abundantNumbers, "\n"; #3719

my @nonAbundantSums = getNonAbundantSums($max);
print "nonAbundantSums: @nonAbundantSums\n";

print "numAbundantSums: @nonAbundantSums\n";
my $sum = 0;
$sum+= $_ foreach(@nonAbundantSums);
print "sum of non-abundant sums: $sum\n";


sub getNonAbundantSums(){
	my @abundantSums = ();
	my $max = $_[0];
	foreach(@abundantNumbers){
		my $num1 = $_;
		foreach(@abundantNumbers){
			my $num2 = $_;
			my $abundantSum = $num1 + $num2;
			if ($abundantSum <= $max){
				$abundantSums[$abundantSum] = 1;
			}
		}
	}
	
	my @nonAbundantSums = ();
	for($i = 0; $i <= $max; $i++){
		if ($abundantSums[$i] != 1){
			push(@nonAbundantSums, $i);
		}
	}
	
	return @nonAbundantSums;
}

sub getAbundantNumbers(){
	my $max = $_[0];
	my @result = ();
	for (my $i = 1; $i <= $max; $i++){
		my @divisors = getDivisors($i);
		my $sum = 0;
		$sum+= $_ foreach(@divisors);
		if ($sum > $i){
			push(@result, $i);
		}
	}
	return @result;
}

sub getDivisors(){
	my $number = $_[0];
	my $max = ceil($number / 2);
	my @result = ();
	for (my $i = 1; $i <= $max; $i++){
		if ($number % $i == 0){
			push(@result, $i);
		}
	}
	return @result;
}