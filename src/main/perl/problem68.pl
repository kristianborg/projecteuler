use strict;

my @solutions = solve();
my $result = 0;
for my $solution (@solutions){
	if (length $solution == 16 && $solution > $result){
		$result = $solution;
	}
}
print "result: $result\n";

sub solve(){
	my @subResult = @_;
	my @result = ();
	for (my $i = 1; $i <= 10; $i++){
		if ($i ~~ @subResult){
			next;
		}
		
		my @subResultClone = clone(@subResult);
		push(@subResultClone, $i);
		if (@subResult <= 5){
			# no limitations on inner ring and first item of outer ring
			push(@result, solve(@subResultClone));
		} else {
			my $target = $subResult[0] + $subResult[1] + $subResult[5];
			my $score = @subResult[(scalar @subResult) % 5] + @subResult[(scalar @subResult + 1) %5] + $i;
			if($score == $target){
				if (@subResult == 9){
					# found a solution
					push(@result, toString(@subResultClone));
				} else {
					push(@result, solve(@subResultClone));
				}
			}
		}
	}
	return @result;
}

sub toString(){
	my $min = 9999;
	my $minPtr = 0;
	for(my $i = 5; $i < 10; $i++){
		if (@_[$i] < $min){
			$min = @_[$i];
			$minPtr = $i;
		}
	}
	
	my $result = "";
	for(my $i = 0; $i < 5; $i++){
		my $ptr = $minPtr + $i;
		if ($ptr >= 10){
			$ptr -= 5;
		}
		$result .= @_[$ptr] . @_[($ptr - 5) % 5] . @_[($ptr - 5 + 1) %5];
	}
	return $result;
}

sub clone(){
	my @result = ();
	push(@result, $_)foreach(@_);
	return @result;
}