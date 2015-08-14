use strict;
use POSIX;
# all possible values that can be thrown with 1 dart
my @dartValues = getDartValues(0);
my $numDartValues = scalar(@dartValues);
print "$numDartValues dart values: @dartValues\n";

# all possible values that can be thrown with 1 dart to finish the game
my @finishingDartValues = getDartValues(1);
my $numFinishingDartValues = scalar(@finishingDartValues);
print "$numFinishingDartValues finishing dart values: @finishingDartValues\n";

# all possible values that can be thrown with up to 2 darts
my @twoDartValues = getTwoDartValues();
my $numTwoDartValues = scalar(@twoDartValues);
print "$numTwoDartValues two dart values: @twoDartValues\n";

my $max = 99;
my $totalOuts = 0;
for (my $i = 2; $i <= $max; $i++){
	my $numOuts = getNumOutsForValue($i);
	print "$i: $numOuts\n";
	$totalOuts += $numOuts;
}
print "total: $totalOuts\n";

sub getNumOutsForValue(){
	my $value = $_[0];
	my $result = 0;
	foreach my $lastDartValueStr (@finishingDartValues){
		my $lastDartValue = extractDartValue($lastDartValueStr);
		if ($lastDartValue > $value){
			next;
		}
		
		if ($lastDartValue == $value){
			$result++;
			next;
		}
		
		my $preFinishValue = $value - $lastDartValue;
		foreach my $combinedDartValueStr (@twoDartValues){
			my $combinedDartValue = extractDartValue($combinedDartValueStr);
			if ($combinedDartValue == $preFinishValue){
				$result++;
			}
		}
	}
	return $result;
}

# input: value1(someString),value2(someString)...
# output: value1 + value2 ...
sub extractDartValue(){
	my $dartStrings = $_[0];
	my $result = 0;
	my @dartStrings = split(",", $dartStrings);
	foreach my $dartString (@dartStrings){
		my $dartValue = substr($dartString, 0, index($dartString, "("));
		$result += $dartValue;
	}
	return $result;
}

sub getDartValues(){
	my $onlyDoubles = $_[0];
	my @result = ("50(BE)");
	if (!$onlyDoubles){
		push(@result, "25(B)");
	}
	for (my $i = 1; $i <= 20; $i++){
		
		my $single = $i;
		if (!$onlyDoubles){
			push(@result, "$single(S$i)");
		}
		
		my $double = 2 * $i;
		push(@result, "$double(D$i)");
		
		my $tripple = 3 * $i;
		if (!$onlyDoubles){
			push(@result, "$tripple(T$i)");
		}
	}
	
	return sort {$a <=> $b} @result;
}

sub getTwoDartValues(){
	my @result = @dartValues;
	for (my $i = 0; $i < scalar @dartValues; $i++){
		my $dart1 = $dartValues[$i];
		for (my $j = $i; $j < scalar @dartValues; $j++){
			my $dart2 = $dartValues[$j];
			my $value = "$dart1,$dart2";
			push(@result, $value);
		}
	}
	return sort {$a <=> $b} @result;
}