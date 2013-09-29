use List::MoreUtils qw/ uniq /;

my $min = 1000;
my $max = 9999;
my @triangleNums = getTriangleNums($min, $max);
my @squareNums = getSquareNums($min, $max);
my @pentagonalNums = getPentagonalNums($min, $max);
my @hexagonalNums = getHexagonalNums($min, $max);
my @heptagonalNums = getHeptagonalNums($min, $max);
my @octagonalNums = getOctagonalNums($min, $max);

for my $triangle(@triangleNums){
	my @cyclics1 = getCyclics($triangle);
	for my $cyclic1(@cyclics1){
		my @figurative1 = getFigurative($cyclic1);		
		if (@figurative1){
			my @cyclics2 = getCyclics($cyclic1);
			for my $cyclic2(@cyclics2){
				my @figurative2 = getFigurative($cyclic2);
				if (@figurative2){
					my @cyclics3 = getCyclics($cyclic2);
					for my $cyclic3(@cyclics3){
						my @figurative3 = getFigurative($cyclic3);
						if (@figurative3){
							my @cyclics4 = getCyclics($cyclic3);
							for my $cyclic4(@cyclics4){
								my @figurative4 = getFigurative($cyclic4);
								if (@figurative4){								
									my @cyclics5 = getCyclics($cyclic4);
									for my $cyclic5(@cyclics5){
										my @figurative5 = getFigurative($cyclic5);
										if (@figurative5){
											if (substr($triangle, 0, 2) == substr($cyclic5, 2, 2)){
												@combined = (@figurative1, @figurative2, @figurative3, @figurative4, @figurative5);
												@uniqCombined = uniq(@combined);
												if (scalar @uniqCombined == 5){
													print "$triangle: tri; $cyclic1: @figurative1; $cyclic2: @figurative2; $cyclic3: @figurative3; $cyclic4: @figurative4; $cyclic5: @figurative5\n";
													print "result: " , $triangle + $cyclic1 + $cyclic2 + $cyclic3 + $cyclic4 + $cyclic5, "\n";
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

sub getFigurative(){
	my @result = ();
	if ($_[0] ~~ @octagonalNums){
		push (@result, "oct");
	}
	if ($_[0] ~~ @heptagonalNums){
		push (@result, "hep");
	}
	if ($_[0] ~~ @hexagonalNums){
		push (@result, "hex");
	}
	if ($_[0] ~~ @pentagonalNums){
		push (@result, "pen");
	}
	if ($_[0] ~~ @squareNums){
		push (@result, "sqr");
	}
	return @result;
}

sub getCyclics(){
	my $input = $_[0];
	my @result = ();
	my $head = substr($input, 2, 2);
	for(my $i = 0; $i <100; $i++){
		if ($i < 10){
			push(@result, $head . "0" . $i);
		} else {
			push(@result, $head . $i);
		}
	}
	return @result;
}

sub getTriangleNums(){
	my $max = $_[0];
	my $max = $_[1];
	my @result = ();
	for(my $i = 0;;$i++){
		$triangleNum = 0.5 * $i * ($i + 1);
		if ($triangleNum < $min){
			next;
		}
		if ($triangleNum > $max){
			last;
		}
		push(@result, $triangleNum);
	}
	return @result;
}

sub getSquareNums(){
	my $max = $_[0];
	my $max = $_[1];
	my @result = ();
	for(my $i = 0;;$i++){
		my $num = $i * $i;
		if ($num < $min){
			next;
		}
		if ($num > $max){
			last;
		}
		push(@result, $num);
	}
	return @result;
}

sub getPentagonalNums(){
	my $max = $_[0];
	my $max = $_[1];
	my @result = ();
	for(my $i = 0;;$i++){
		my $num = 0.5 * $i * (3 * $i - 1);
		if ($num < $min){
			next;
		}
		if ($num > $max){
			last;
		}
		push(@result, $num);
	}
	return @result;
}

sub getHexagonalNums(){
	my $max = $_[0];
	my $max = $_[1];
	my @result = ();
	for(my $i = 0;;$i++){
		my $num = $i * (2 * $i - 1);
		if ($num < $min){
			next;
		}
		if ($num > $max){
			last;
		}
		push(@result, $num);
	}
	return @result;
}

sub getHeptagonalNums(){
	my $max = $_[0];
	my $max = $_[1];
	my @result = ();
	for(my $i = 0;;$i++){
		my $num = 0.5 * $i * (5 * $i - 3);
		if ($num < $min){
			next;
		}
		if ($num > $max){
			last;
		}
		push(@result, $num);
	}
	return @result;
}

sub getOctagonalNums(){
	my $max = $_[0];
	my $max = $_[1];
	my @result = ();
	for(my $i = 0;;$i++){
		my $num = $i * (3 * $i - 2);
		if ($num < $min){
			next;
		}
		if ($num > $max){
			last;
		}
		push(@result, $num);
	}
	return @result;
}