use FileHandle;
use strict;

my @matrix = readMatrix("problem81.txt");
@matrix = (
	[131,	673,	234,	103,	18],
	[201,	96,		342,	965,	150],
	[630,	803,	746,	422,	111],
	[537,	699,	497,	121,	956],
	[805,	732,	524,	37,		331]
);

@matrix = (
	[1,	    1,  	999,	999,	999],
	[1,  	1,		999,	999,	999],
	[500,	500,	500,	999,	999],
	[999,	999,	1,  	999,	999],
	[999,	999,	1,  	1,		1]
);

my @cache = ();
my $size = scalar @matrix;
my $result =solve(2, 10);
print "result: $result\n";
exit;
for(my $maxDepth = 2; $maxDepth <= $size * 2; $maxDepth++){
	for(my $y2 = 0; $y2 < $size; $y2++){
		my $score = solve($y2, $maxDepth);
		print "result: $maxDepth - $y2: $score\n";
	}
}

my $bla = 0;
sub solve(){
	my $y = $_[0];
	my $maxDepth = $_[1];
	my $x = 0;
	my $total = $matrix[$y][$x];
	my $upAllowed = 1;
	my $downAllowed = 1;
	while (1){
		my @subResult = getBestSolution($maxDepth, $x, $y, 0, 0);
		$x = $subResult[0];
		$y = $subResult[1];
		$upAllowed = $subResult[2];
		$downAllowed = $subResult[3];
		my $score = $matrix[$y][$x];
		print "chosing ($x, $y) = $score\n";
		$total += $score;
		
		$bla++;
		if ($bla >= 10){
			#last;
		}
		
		if ($x == $size - 1){
			last;
		}
	}
	return $total;
}

sub getBestSolution(){
	my $maxDepth = $_[0];
	my $x = $_[1];
	my $y = $_[2];
	my $upAllowed = $_[3];
	my $downAllowed = $_[4];
	print "getBestSolution(maxDepth=$maxDepth, x=$x, y=$y, upAllowed=$upAllowed, downAllowed=$downAllowed)\n";
	if ($x == ($size - 1)){
		print "edge reached for getBestSolution(maxDepth=$maxDepth, x=$x, y=$y, upAllowed=$upAllowed, downAllowed=$downAllowed)\n";
		return ($x, $y, $matrix[$y, $x], 1, 1);
	}
	
	if ($y == 0){
		$upAllowed = 0;
	}
	
	if ($y == ($size - 1)){
		$downAllowed = 0;
	}
	
	print "updated getBestSolution(maxDepth=$maxDepth, x=$x, y=$y, upAllowed=$upAllowed, downAllowed=$downAllowed)\n";
	
	my $rightX = $x + 1;
	my $rightY = $y;
	my $downX = $x;
	my $downY = $y + 1;
	my $upX = $x;
	my $upY = $y - 1;
	
	my $rightScore = $matrix[$rightY][$rightX];
	my $downScore = $matrix[$downY][$downX];
	my $upScore = $matrix[$upY][$upX];
	
	if ($maxDepth > 1){
		my @rightResult = getBestSolution($maxDepth - 1, $rightX, $rightY, 1, 1);
		$rightScore += $rightResult[2];
		
		if($downAllowed){
			my @downResult = getBestSolution($maxDepth - 1, $downX, $downY, 0, 1);
			$downScore += $downResult[2];
		}
		
		if($upAllowed){
			my @upResult = getBestSolution($maxDepth - 1, $upX, $upY, 1, 0);
			$upScore += $upResult[2];
		}
	}

	my @result;
	if ($downScore <= $upScore && $downScore <= $rightScore && $downAllowed){
		@result = ($downX, $downY, $downScore, 0, 1);
	} elsif ($upScore <= $downScore && $upScore <= $rightScore && $upAllowed) {
		@result = ($upX, $upY, $upScore, 1, 0);
	} else {
		@result = ($rightX, $rightY, $rightScore, 1, 1);
	}
	
	print "result getBestSolution(maxDepth=$maxDepth, x=$x, y=$y, upAllowed=$upAllowed, downAllowed=$downAllowed) = @result\n";
	return @result;
}


sub getBestSolution2(){
	my $maxDepth = $_[0];
	my $x = $_[1];
	my $y = $_[2];
	my $upAllowed = $_[3];
	my $downAllowed = $_[4];
	print "getBestSolution($maxDepth, $x, $y)\n";
	
	print "getBestSolution($maxDepth, $x, $y)\n";
	
	my $rightDone = $x == ($size - 1);
	my $downDone = !$downAllowed || $y == ($size - 1);
	my $upDone = !$upAllowed || ($y == 0);
	
	if ($rightDone){
		return ($x, $y, $matrix[$y, $x]);
	}

	my $rightX = $x + 1;
	my $rightY = $y;
	my $rightKey = $rightX * $size ** 3 + $rightY * $size ** 2 + $maxDepth;
	
	my $downX = $x;
	my $downY = $y + 1;
	my $downKey = $downX * $size ** 3 + $downY * $size ** 2 + $maxDepth;
	
	my $upX = $x;
	my $upY = $y - 1;
	my $upKey = $upX * $size ** 3 + $upY * $size ** 2 + $maxDepth;
	
	my $rightScore = $matrix[$rightY][$rightX];
	my $downScore = $matrix[$downY][$downX];
	my $upScore = $matrix[$upY][$upX];
	
	if ($maxDepth > 1){
		if ($rightDone){
			$rightScore = 99999999;
		} elsif ($cache[$rightKey]) {
			$rightScore = $cache[$rightKey];
		} else {
			my @rightResult = getBestSolution2($maxDepth - 1, $rightX, $rightY, 1, 1);
			$rightScore += $rightResult[2];
			#$cache[$rightKey] = $rightScore;
		}
		
		if ($downDone){
			$downScore = 99999999;
		} elsif ($cache[$downKey]) {
			$downScore = $cache[$downKey];
		} else {
			my @downResult = getBestSolution2($maxDepth - 1, $downX, $downY, 0, 1);
			$downScore += $downResult[2];
			#$cache[$downKey] = $downScore;
		}
		
		if ($upDone){
			$upScore = 99999999;
		} elsif ($cache[$upKey]) {
			$upScore = $cache[$upKey];
		} else {
			my @upResult = getBestSolution2($maxDepth - 1, $upX, $upY, 1, 0);
			$upScore += $upResult[2];
			#$cache[$upKey] = $upScore;
		}
	}
	
	print ("getBestSolution($maxDepth, $x, $y) - ($x, $y) - $rightScore, $downScore, $upScore\n");
	if ($y > 15){
		exit;
	}
	
	if ($rightScore <= $downScore && $rightScore <= $upScore && !$rightDone){
		return ($rightX, $rightY, $rightScore);
	} elsif ($downScore <= $upScore && $downScore <= $rightScore && !$downDone){
		return ($downX, $downY, $downScore);
	} else {
		if ($upDone){
			print "huh!\n";
			exit;
		}
		return ($upX, $upY, $upScore);
	}
}

sub readMatrix(){
	my $fh = FileHandle->new;
	if (!$fh->open("< $_[0]")) {
		print "failed to open file\n";
		exit;
	}
	
	my @result = ();
	while(my $line = $fh->getline){
		push(@result, [split(",", $line)]);
	}
	$fh->close;	
	return @result;
}

sub getAverage(){
	my $total = 0;
	my $numItems = 0;
	for(my $i = 0; $i < scalar @matrix; $i++){
		for(my $j = 0; $j < scalar @matrix; $j++){
			$total += $matrix[$i][$j];
			$numItems++;
		}
	}
	print "$total / $numItems\n";
	return $total / $numItems;
}