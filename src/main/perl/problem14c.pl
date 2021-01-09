@test1 = (1,2);
print "1 @test1\n";
$max = 2;
$highestPtr = 0;
$highestLengthPtr = 1;
$highestLength = 1;
@chains = ();
$lengthIdx = 0;
$nextIdx = 1;
$chains[1] = (1, 1);

@a = (1,2);
print "a: @a\n";
$frits[1] = ($a);

@b = @{$frits[1]};
print "b: @b\n";

print "temp: $temp[0] $temp[1]\n";
for(my $i = 2; $i <= $max; $i++){
	print "processing $i\n";
	my $currentPtr = $i;
	my @current = $chains[$currentPtr];
	print "current before pag @current\n";
	if (!$current){
		print "calling pag\n";
		@current = populateAndGet($currentPtr);
		print "current after pag @current\n";
	}
	
	if ($current[$lengthIdx] > $highestLength){
		$highestLengthPtr = $currentPtr;
		$highestLength = $current[$lengthIdx];
		print "new longest chain: $i - $current[lengthIdx] \n";
	}
	print "$i, next:$current[$nextIdx], length: $current[$lengthIdx]\n" ;
}

print "Number with longest chain: $highestLengthPtr has length $highestLength\n";
my $next = $highestLengthPtr;
$i = 1;
#print "Chain: $next ";
#while ($next != 1){
	$i++;
	$next = $chains[$next][$nextIdx]; 
	#print "-> $next ";
#}
#print "\n";

sub populateAndGet {
	my $currentPtr = $_[0];
	print "pag called with $currentPtr\n";
	my $nextPtr = 0;
	if($currentPtr %2 == 0){
		$nextPtr = $currentPtr / 2;
		#n → n/2 (n is even)
	} else {
		$nextPtr = $currentPtr * 3 + 1;
		#n → 3n + 1 (n is odd)
	}
	
	my @next = $chains[$nextPtr];
	if (@$next){
		@next = populateAndGet($nextPtr);
		$chains[$nextPtr] = @next;
	} else {
		print "pag found next: @next\n"
	}
	
	my $currentLength = $next[$lengthIdx] + 1;
	my @current = ($currentLength, $nextPtr);
	$chains[$currentPtr] = @current;
	print "pag returning current @current\n";
	return @current;
}