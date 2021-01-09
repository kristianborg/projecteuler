use POSIX;
use strict;
use Math::BigInt;

my $target = 100;

my @fractions = getFractionsOfE($target);
my @convergant = getConvergant(@fractions);
my $numerator = $convergant[0];
my $denominator = $convergant[1];
my $numeratorSum = 0;
$numeratorSum += $_ foreach(split("", $numerator));
print "$numerator / $denominator; sum: $numeratorSum\n";

sub getFractionsOfE(){
	my $numFractions = $_[0];
	my @result = (2);
	for(my $i = 0; $i < $numFractions - 1; $i++){
		if ($i % 3 == 1){
			push (@result, 2 * (floor($i / 3) + 1));
		} else {
			push(@result, 1);
		}
	}
	return @result;
}

sub getConvergant(){
	my @fractions = @_;
	my $numerator = Math::BigInt->new(1);
	my $denominator = Math::BigInt->new(pop(@fractions));
	while(1){
		my $fraction = pop(@fractions);
		$numerator = $numerator + $fraction * $denominator;
		
		if (@fractions){
			# swap
			($numerator, $denominator) = ($denominator, $numerator);
		} else {
			return ($numerator, $denominator);
		}
	}
}