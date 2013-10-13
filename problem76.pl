use strict;
# 50=2; 60=6; 70=20; 80=105; 90=420; 100=
my $target = 100;
my $result = findSummation($target, $target - 1);
print "result: $result\n";

sub findSummation(){
	my $target = $_[0];
	my $maxDigit = $_[1];
	if ($target == 1){
		1;
	}
	
	my $result = 0;
	for(my $i = 1; $i <= $maxDigit && $i < $target; $i++){
		$result += findSummation($target - $i, $i);
	}
	if ($target <= $maxDigit){
		$result++;
	}
	return $result;
}

sub findSummation2(){
	my $target = $_[0];
	my $maxDigit = $_[1];
	if ($target == 1){
		return ("+ 1\n");
	}
	
	my @result = ();
	for(my $i = 1; $i <= $maxDigit && $i < $target; $i++){
		my @subResult = findSummation2($target - $i, $i);
		foreach(@subResult){
			push(@result, "+ $i " . $_);
		}
	}
	if ($target <= $maxDigit){
		push(@result, "+ $target\n");
	}
	return @result;
}
