use POSIX;

my $i = 1;
my @cache = ();
while(1){
	my $pent = getPentagonal($i);
	foreach(@cache){
		my $prevPent = $_;
		my $sum = $pent + $prevPent;
		my $diff = $pent - $prevPent;
		
		if (isPentagonal($sum) && isPentagonal($diff)){
			print "$i: sum and diff of $pent and $prevPent ($sum and $diff) is pentagonal\n";
			exit;
		}
	}
	
	$cache[($i - 1)] = $pent;
	$i++;
}


sub getPentagonal(){
	return $_[0] * (3 * $_[0] - 1) / 2;
}

sub isPentagonal(){
	my $i = $_[0] * 24 + 1;
	my $sqrt = sqrt($i);
	my $result =  floor($sqrt) == $sqrt && $sqrt % 6 == 5;
	return $result;
}
