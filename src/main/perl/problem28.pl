my $ring = 0;
my $pos = 0;
my $size = 1001;
my $max = $size * $size;

$total = 0;
my $i = 1;
while($i <= $max){
	print "adding $i (ring $ring, pos $pos)\n";
	$pos++;
	$total += $i;
	if ($i == 1 || $pos == 4){
		$pos = 0;
		$ring++;
	}
	$i += $ring * 2;
}
print "total: $total\n";