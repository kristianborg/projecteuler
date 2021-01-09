my $max = 10000;
my $lycherelLimit = 50;
my $numLycherels = 0;
for(my $i = 10; $i < $max; $i++){
	my @chain = ($i);
	my $current = $i;
	while(1){
		$current += reverse $current;
		push(@chain, $current);
		if (isPalindrome($current)){
			last;
		} elsif (scalar @chain > $lycherelLimit){
			print "$i is a lycherel number\n";
			$numLycherels++;
			last;
		}
	}
}
print "result: $numLycherels\n";

sub isPalindrome(){
	return $_[0] == reverse($_[0]);
}
