use POSIX;
my $max = 10000;

my @divSums = ();
for (my $i = 2; $i < $max; $i++){
	my $divSum = getDivisorSum($i);
	$divSums[$i] = $divSum;
}

my $divSum = $divSums[220];
my $divSum2 = $divSums[284];
print ("XXX $divSum $divSum2\n");

my @amicables = ();
for (my $i = 2; $i < $max; $i++){
	my $divSum = $divSums[$i];
	my $divSum2 = $divSums[$divSum];
	if ($i == $divSum2 && $i != $divSum){
		push(@amicables, $i);
		print "ading $i - $divSum - $divSum2\n";
	}
}
print "amicables: @amicables\n";
my $sum = 0;
$sum+= $_ foreach(@amicables);
print "result: $sum\n";

sub getDivisorSum(){
	my $number = $_[0];
	my @result = ();
	for (my $i = 1; $i < $number; $i++){
		if ($number % $i == 0){
			push(@result, $i);
		}
	}
	my $sum = 0;
	$sum+= $_ foreach(@result);
	return $sum;
}