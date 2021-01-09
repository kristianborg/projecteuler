use strict;
use POSIX;

my @fibHeads = (0,1,1);
my @fibTails = (0,1,1);

my $max = 1000000;
for (my $i = 3; $i <= $max; $i++){
	my $fibHead = fibHead($i);
	my $fibTail = fibTail($i);
	my $head = substr($fibHead, 0, 9);
	my $tail = substr($fibTail, -9, 9);
	my $headPandigital = isPandigital($head);
	my $tailPandigital = isPandigital($tail);
	if ($headPandigital){
		print "fib $i has pandigital head: $head\n";
	}
	if ($tailPandigital){
		print "fib $i has pandigital tail: $tail\n";
	}
	
	if ($headPandigital && $tailPandigital){
		print "fib $i has pandigital head: $head AND tail: $tail\n";
		print "done\n";
		exit;
	}
}

sub fibHead(){
	my $fibHead1 = $fibHeads[$_[0] - 2];
	my $fibHead2 = $fibHeads[$_[0] - 1];
	my $fibHead3 = $fibHead1 + $fibHead2;
	if (length($fibHead2) == length($fibHead3)){
		$fibHead2 = substr($fibHead2, 0, 18);
		$fibHeads[$_[0] - 1] = $fibHead2;
		$fibHead3 = substr($fibHead3, 0, 18);
		
	}
	$fibHeads[$_[0]] = $fibHead3;
	return $fibHead3;
}

sub fibTail(){
	my $result =  $fibTails[$_[0] - 1] + $fibTails[$_[0] - 2];
	$result = substr($result, -18, 18);
	$fibTails[$_[0]] = $result;
	return $result;
}

sub isPandigital(){
	my @inputDigits = (split "", $_[0]);
	my @digits = (1);
	if (scalar @inputDigits != 9){
		return 0;
	}
	foreach my $inputDigit (@inputDigits){
		if ($digits[$inputDigit]){
			return 0;
		} else {
			$digits[$inputDigit] = 1;
		}
	}
	return 1;
}