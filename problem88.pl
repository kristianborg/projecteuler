use POSIX;
use strict;

my @cachedProductBreakdowns = ();

my $max = 12000;
#my $max = 12;
my @minProductSums = ();
for (my $k = 2; $k <= $max; $k++){
	my $minProductSum = findMinProductSum($k);
	print "minimal product sum for k=$k: $minProductSum\n";
	$minProductSums[$minProductSum] = 1;
}
my $result = 0;
for (my $x = 1; $x <= scalar @minProductSums; $x++){
	if ($minProductSums[$x]){
		$result += $x;
	}
}
print "The sum of all unique minimal product sums untill $max is: $result\n";

sub findMinProductSum(){
	my $targetItems = $_[0];
	for(my $sum = $targetItems; $sum <= $targetItems * 3; $sum++){
		my $strProductBreakdowns = getCachedProductBreakdown($sum);
		my @productBreakdowns = split("\\|", $strProductBreakdowns);
		for my $strProductBreakdown (@productBreakdowns){
			my @productBreakdown = split("x", $strProductBreakdown);
			if (hasMatchingProductSum($targetItems, $sum, \@productBreakdown)){
				return $sum;
			}
		}
	}
}

sub hasMatchingProductSum(){
	my $targetItems = $_[0];
	my $targetSum = $_[1];
	my @values = @{$_[2]};
	
	my $missingItems = $targetItems - scalar @values;
	my $sum = $missingItems;
	$sum += $_ foreach @values;
	if ($sum == $targetSum){
		return 1;
	} else {
		return 0;
	}
}

sub getCachedProductBreakdown(){
	my $product = $_[0];
	if ($cachedProductBreakdowns[$product]){
		return $cachedProductBreakdowns[$product];
	}
	
	my @productBreakdowns = getProductBreakdown($product, $product);
	my $strProductBreakdowns = "";
	$strProductBreakdowns .= $_ . "|"  foreach @productBreakdowns;
	$cachedProductBreakdowns[$product] = $strProductBreakdowns;
	return $strProductBreakdowns;
}


sub getProductBreakdown(){
	my $leftoverProduct = $_[0];
	my $maxValue = $_[1];
	
	my @divisors = getDivisors($leftoverProduct, $maxValue);
	my @productBreakdowns = ();
	
	for my $divisor(@divisors){
		if ($divisor == $leftoverProduct){
			push(@productBreakdowns, $divisor)
		} else {
			my @subProductBreakdowns = getProductBreakdown($leftoverProduct / $divisor, $divisor);
			for my $subProductBreakdown(@subProductBreakdowns){
				push(@productBreakdowns, $divisor . "x" . $subProductBreakdown);
			}
		}
	}
	
	return @productBreakdowns;
}

sub getDivisors(){
	my $product = $_[0];
	my $maxValue = $_[1];
	my @divisors = ();
	for (my $divisor = 2; $divisor <= $maxValue; $divisor++){
		if ($product % $divisor == 0){
			push(@divisors, $divisor);
		}
	}
	return @divisors;
}