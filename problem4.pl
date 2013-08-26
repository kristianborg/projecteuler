use POSIX;

$start = 100;
$end = 999;
$product1 = 0;
$product2 = 0;
$result = 0;
for($i = $start; $i <= $end; $i++){
	for($j = $start; $j <= $end; $j++){
		$product = $i * $j;
		if (isPalindrome($product) && $product > $result){
			$result = $product;
			$product1 = $i;
			$product2 = $j;
			print "temp result: $i * $j = $result\n";
		}
	}
}
print "result: $product1 * $product2 = $result\n";

sub isPalindrome {
	$origString = $_[0];
	@chars = split(//, $_[0]);
	$reverseString = reverse @chars;
	my $result = reverse $origString eq $reverseString;
	#if ($result){
	#	print "Palindrome: $origString\n";
	#}
	return $result;
}