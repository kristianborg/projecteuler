my $max = 1000000;
my $result = 0;
for (my $decimal = 1; $decimal <= $max; $decimal++){
	if (!isPalindrome($decimal)){
		next;
	}
	my $binary = sprintf "%b", $decimal;
	if (isPalindrome($binary)){
		$result += $decimal;
		print "$decimal - $binary\n";
	}
}
print "result: $result\n";

sub isPalindrome(){
	my $original = $_[0];
	my $reverse = reverse($original);
	return $original == $reverse;
}