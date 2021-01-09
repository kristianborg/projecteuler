use POSIX;
use strict;
my @cache;
my $max = 60000;
my $modulus = 1000000;
for (my $i = 1; $i <= $max; $i++){
	my $result = findSummation($i, $i);
	print "$i: $result\n";
	if ($result == 0){
		last;
	}
}

sub findSummation(){
	my $target = $_[0];
	my $maxDigit = $_[1];
	if ($target == 1){
		1;
	}
	
	my $key = $max * $target + $maxDigit;
	if ($cache[$key]){
		return $cache[$key];
	}
	
	my $result = 0;
	for(my $i = 1; $i <= $maxDigit && $i < $target; $i++){
		$result += findSummation($target - $i, $i);
	}
	if ($target <= $maxDigit){
		$result++;
	}
	
	$result %= $modulus;
	$cache[$key] = $result;
	if ($target == $maxDigit){
		for(my $i = $maxDigit + 1; $i < $max - $target; $i++){
			my $key2 = $max * $target + $i;
			$cache[$key2] = $result;
		}
	}
	return $result;
}