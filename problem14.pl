$max = 1000000;
@longestChain = ();
for ($i = 2; $i <= $max; $i++){
	@chain = ($i);
	$number = $i;
	while($number != 1){
		if($number %2 == 0){
			$number = $number / 2;
			#n → n/2 (n is even)
		} else {
			$number*=3;
			$number++;
			#n → 3n + 1 (n is odd)
		}
		push(@chain, $number);
	}
	if ($#chain > $#longestChain){
		@longestChain = @chain;
		print "new chain: $i - ", $#chain + 1, "\n";
	}
	#print "$i: @chain\n";
}