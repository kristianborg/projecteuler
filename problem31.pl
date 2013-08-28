use POSIX;

# '1' has to be the first element in the list
my @coins = (1, 2, 5, 10, 20, 50, 100, 200);
my $target = 200;
my $result = getPermutations($target, \@coins, "");
print "result: $result\n";
sub getPermutations(){
	my $target = $_[0];
	my $coins = $_[1];
	my @coins = @{$coins};
	
	if ((scalar @coins) == 1){
		return return 1;
	}
	
	my $coin = pop(@coins);
	my $result = 0;
	for (my $i = 0; $i <= floor($target / $coin); $i++){
		my $tempTarget = $target - $i * $coin;
		$result+= getPermutations($tempTarget, \@coins);
	}
	return $result;
}