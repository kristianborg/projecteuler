$max = 200000;
$highestPtr = 0;
$highestLengthPtr = 1;
$highestLength = 1;
@chains = ();
$chains[1] = {'next' => 1, 'length' => 1};
for(my $i = 2; $i <= $max; $i++){
	#print "processing $i\n";
	my $currentPtr = $i;
	my %current = %{$chains[$currentPtr]};
	
	if (!%current){
		%current = populateAndGet($currentPtr);
	}
	
	if ($current{length} > $highestLength){
		$highestLengthPtr = $currentPtr;
		$highestLength = $current{length};
		print "new longest chain: $i - $current{length} \n";
	}
}

print "Number with longest chain: $highestLengthPtr has length $highestLength\n";
my $next = $highestLengthPtr;
$i = 1;
#print "Chain: $next ";
while ($next != 1){
	$i++;
	$next = $chains[$next]{next}; 
	#print "-> $next ";
}
#print "\n";

sub populateAndGet {
	my $currentPtr = $_[0];
	my $nextPtr = 0;
	if($currentPtr %2 == 0){
		$nextPtr = $currentPtr / 2;
		#n → n/2 (n is even)
	} else {
		$nextPtr = $currentPtr * 3 + 1;
		#n → 3n + 1 (n is odd)
	}
	
	my %next = %{$chains[$nextPtr]};
	if (!%next){
		%next = populateAndGet($nextPtr);
		$chains[$nextPtr] = {%next};
	}
	
	my $currentLength = $next{length} + 1;
	my %current = ('next' => $nextPtr, 'length' => $currentLength);
	$chains[$currentPtr] = {%current};
	return %current;
}