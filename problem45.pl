my $i = 286;
$lastPentN = 0;
$lastHexN = 0;
while(1){
	my $triangle = getTriangle($i);
	#print "$i: $triangle\n";
	if (isPentagonal($triangle) & isHexagonal($triangle)){
		print "triangle number $triangle (n = $i) is also pentagonal and hexagonal\n";
		last;
	}
	$i++;
}

sub isHexagonal(){
	while(1){
		my $hexagonal = getHexagonal($lastHexN);
		if ($hexagonal > $_[0]){
			#print "$_[0] is NOT hexagonal\n";
			return 0;
		} elsif ($hexagonal == $_[0]){
			#print "$_[0] is hexagonal for n = $lastHexN\n";
			return 1;
		} else {
			$lastHexN++;
		}
	}
}

sub getHexagonal(){
	return $_[0] * (2 * $_[0] - 1);
}

sub getTriangle(){
	return ($_[0] * ($_[0] + 1)) / 2;
}

sub isPentagonal(){
	while(1){
		my $pentagonal = getPentagonal($lastPentN);
		if ($pentagonal > $_[0]){
			#print "$_[0] is NOT pentaagonal\n";
			return 0;
		} elsif ($pentagonal == $_[0]){
			#print "$_[0] is pentaagonal for n = $lastPentN\n";
			return 1;
		} else {
			$lastPentN++;
		}
	}
}

sub getPentagonal(){
	return $_[0] * (3 * $_[0] - 1) / 2;
}