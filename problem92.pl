use strict;
use POSIX;

my $max=10000000;
my @results = ();

my $num89s = 0;
for(my $i = 1; $i < $max; $i++){
	my $result = solve($i);
	if ($i % 100 == 0){
		print "$i: $result\n";
	}
	if ($result == 89){
		$num89s++;
	}
}
print "numbers below $max resulting in 89: $num89s\n";

sub solve(){
	my $number = $_[0];
	if ($number == 1){
		return 1;
	} elsif($number == 89){
		return 89;
	} elsif ($results[$number]){
		return $results[$number];
	} else {
		my $squareDigit = getSquareDigit($number);
		my $result = solve($squareDigit);
		$results[$number] = $result;
		return $result;
	}
}

sub getSquareDigit(){
	my $squareSum = 0;
	$squareSum += $_ ** 2 foreach split "", $_[0];
	#print "input $_ result $squareSum\n";
	return $squareSum;
}