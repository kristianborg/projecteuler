use strict;
use POSIX;
 
my $maxN = 7;
my $maxSum = 300;

for(my $n = 1; $n <= $maxN; $n++){
	my $found = 0;
	for (my $sum = $n; $sum <= $maxSum; $sum++){
		my @sumSets = findSumSets($n, $sum, []);
		#print "trying sum=$sum with " . scalar @sumSets . " candidates\n";
		my @specialSumSet = extractSpecialSumSet(@sumSets);
		if (@specialSumSet){
			print "n = $n: @specialSumSet (size = $sum)\n";
			last;
		}
	}
}

sub findSumSets(){
	my $numElements = $_[0];
	my $sum = $_[1];
	my @subSet = @{$_[2]};
	my @subSets = ();
	
	my $minValue = $subSet[-1] + 1;
	my $maxValue = floor($sum / $numElements);
	if (scalar @subSet >= 2){
		my $maxValue2 = $subSet[0] + $subSet[1] - 1;
		if ($maxValue2 < $maxValue){
			$maxValue = $maxValue2;
		}
	}
	
	if ($numElements == 1){
		if ($sum >= $minValue && $sum <= $maxValue){
			push(@subSet, $sum);
			push(@subSets, \@subSet);
		} 
	} else {
		for (my $value = $minValue; $value <= $maxValue; $value++){
			my @newSubSet = @subSet;
			push(@newSubSet, $value);
			my @newSubSets = findSumSets($numElements - 1, $sum - $value, \@newSubSet);
			foreach my $bla (@newSubSets){
				push(@subSets, $bla);
			}
		}
	}
	
	if (scalar @subSet >= 3){
		for (my $a = 0; $a < scalar @subSet; $a++){
			for (my $b = $a + 1; $b < scalar @subSet; $b++){
				my $sum1 = $subSet[$a] + $subSet[$b];
				for (my $i = 0; $i < scalar @subSet; $i++){
					for (my $j = $i + 1; $j < scalar @subSet; $j++){
						if ($a != $i || $b != $j){
							my $sum2 = $subSet[$i] + $subSet[$j];
							if ($sum1 == $sum2){
								return ();
							}
						}
					}
				}
			}
		}
	}
	return @subSets;
}

 
sub extractSpecialSumSet(){
	foreach my $sumSet (@_){
		my @sumSet = @{$sumSet};
		if (isSpecialSumSet(@sumSet)){
			return @sumSet;
		}
	}
	return ();
}

sub isSpecialSumSet(){
	my @sumSet = @_;
	my @subSets = ();
	
	for (my $subSetSize = 1; $subSetSize < scalar @sumSet; $subSetSize++){
		my @subSubSets = getSubSets(\@sumSet, $subSetSize, 0);
		push (@subSets, @subSubSets);
	}
	
	for (my $i = 0; $i < scalar @subSets; $i++){
		my @subSet1 = @{$subSets[$i]};
		for (my $j = $i + 1; $j < scalar @subSets; $j++){
			my @subSet2 = @{$subSets[$j]};
			#print "trying @subSet1 and @subSet2\n";
			if (!isDisjoint(\@subSet1, \@subSet2)){
				next;
			}
			my $subSet1Size = getSize(@subSet1);
			my $subSet2Size = getSize(@subSet2);
			if ($subSet1Size == $subSet2Size){
				#print "@sumSet is not a special sumset because subsets @subSet1 and @subSet2 have the same size $subSet1Size\n";
				return 0;
			} elsif (scalar @subSet1 > scalar @subSet2 && $subSet1Size < $subSet2Size){
				#print "@sumSet is not a special sumset because @subSet1 has more elements than @subSet2 but has a smaller size ($subSet1Size vs $subSet2Size)\n";
				return 0;
			} elsif (scalar @subSet2 > scalar @subSet1 && $subSet2Size < $subSet1Size){
				#print "@sumSet is not a special sumset because @subSet2 has more elements than @subSet1 but has a smaller size ($subSet2Size vs $subSet1Size)\n";
				return 0;
			}
		}
	}
	#print "@sumSet is a special sumset\n";
	return 1;		
}

sub isDisjoint(){
	my @set1 = @{$_[0]};
	my @set2 = @{$_[1]};
	foreach my $item (@set1){
		if ($item ~~ @set2){
			#print "@set1 and @set2 are NOT disjoint\n";
			return 0;
		}
	}
	#print "@set1 and @set2 are disjoint\n";
	return 1;
}
 
sub getSubSets(){
	my @set = @{$_[0]};
	my $subSetSize = $_[1];
	my $minItem = $_[2];
	my $setSize = scalar(@set);
	my @subSets = ();
	if ($subSetSize == 1){
		for (my $i = $minItem; $i < $setSize; $i++){
			my @subSet = ($set[$i]);
			push(@subSets, \@subSet);
		}
	} else {
		for (my $i = $minItem; $i <= $setSize - $subSetSize; $i++){
			my @partialSubsets = getSubSets(\@set, $subSetSize - 1, $i + 1);
			foreach my $partialSubset (@partialSubsets){
				my @subSet = ($set[$i]);
				push(@subSet, @{$partialSubset});
				push(@subSets, \@subSet);
			}
		}
	}
	return @subSets;
}
  
sub getSize(){
	my $result = 0;
	$result += $_ foreach @_;
	return $result;
}