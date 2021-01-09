use POSIX;
my $max = 1000;

for(my $d = 2; $d < $max; $d++){
	if (isSquare($d)){
		next;
	}
	getMinX($d);
}

sub getMinX(){
	my $d = $_[0];
	my $x = 2;
	while(1){
		#x^2 – Dy^2 = 1; so sqrt((x^2 – 1)/D) = y
		my $y = sqrt(($x ** 2 - 1) / $d);
		if ($y == floor($y)){
			print "$x^2 - $d*$y^2 = 1\n";
			return $y;
		}
		$x++;
	}
}

sub isSquare(){
	my $sqrt = sqrt($_[0]);
	return $sqrt == floor($sqrt);
}