use strict;
use POSIX;
 
my @operations = ("+", "-", "*", "/");
my $max = 10;
 
my $bestResult = 0;
for (my $a = 1; $a <= $max; $a++){
	for (my $b = $a + 1; $b <= $max; $b++){
		for (my $c = $b + 1; $c <= $max; $c++){
			for (my $d = $c + 1; $d <= $max; $d++){
				my @values = ($a, $b, $c, $d);
				my $result = solve(\@values);
				if ($result > $bestResult){
					$bestResult = $result;
					print "@values = $bestResult\n";
				}
			}
		}
	}
}
print "done\n";
 
 
sub solve(){
	my @values = @{$_[0]};
	my @computations = getComputations(\@values);
	my @foundInts = ();
	my $numInts = 0;
	foreach my $computation (@computations){
		my $result = eval($computation);
		if (isPositiveInt($result)){
			if (!$foundInts[$result]){
				$foundInts[$result] = 1;
				$numInts++;
			}
		}
	}
 
	my $numConsecutiveInts = 0;
	for (my $i = 1; $i < scalar @foundInts; $i++){
		if ($foundInts[$i]){
			$numConsecutiveInts++;
		} else {
			last;
		}
	}
	#print "[@values] has $numInts unique solutions and $numConsecutiveInts consecutive solutions\n";
	return $numConsecutiveInts;
}
 
sub isPositiveInt(){
	return $_[0] > 0 && index($_[0], ".") == -1;
}
 
sub getComputations(){
	my @valuesLeft = @{$_[0]};
 
	if (scalar @valuesLeft == 1){
		return $valuesLeft[0];
	}
 
	my @result = ();
	foreach my $value (@valuesLeft){
		my @newValuesLeft = removeFromArray(\@valuesLeft, $value);
		foreach my $operation (@operations){		
			my @subResults = getComputations(\@newValuesLeft);
			foreach my $subResult (@subResults){
				push(@result, "$value $operation ( $subResult )");
				push(@result, "( $subResult ) $operation $value");
			}
		}
	}
 
	if (scalar @valuesLeft >= 2){
		foreach my $value1 (@valuesLeft){
			my @newValuesLeft = removeFromArray(\@valuesLeft, $value1);
			foreach my $value2 (@newValuesLeft){
				my @newNewValuesLeft = removeFromArray(\@newValuesLeft, $value2);
				foreach my $operation1 (@operations){		              
					foreach my $operation2 (@operations){
						my @subResults = getComputations(\@newNewValuesLeft);
						foreach my $subResult (@subResults){
							push(@result, "( $value1 $operation1 $value2) $operation2 ( $subResult )");
							push(@result, "( $subResult ) $operation2 ( $value1 $operation1 $value2)");
						}
					}
				}
			}
		}
	}
 
	return @result;
}
 
sub removeFromArray(){
	my @array = @{$_[0]};
	my $toRemove = $_[1];
	my @result = ();
	foreach my $value (@array){
		if ($value ne $toRemove){
			push(@result, $value);
		}
	}
	return @result;
}