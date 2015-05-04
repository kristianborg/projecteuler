use POSIX;
use strict;

my $max = 3000;
my $target = 1000000;
my @pairs = ();
populateIntCubeSumSqrtPairs($max * 2);
print "result: @pairs\n";


my $totalShortestPaths = 0;
for (my $i = 1; $i <= $max; $i++){
	print "processing i=$i\n";
	$totalShortestPaths += findCubesWithIntegerShortestPath($i);
	if ($totalShortestPaths >= $target){
		print "number of shortest paths exceeds $target for max kuboid edge size = $i\n";
		last;
	}
}
print "total number of shortest paths for max kuboid edge size $max: $totalShortestPaths\n";

sub populateIntCubeSumSqrtPairs() {
	my $max = $_[0];
	for(my $x = 1; $x <= $max; $x++){
		for(my $y = $x; $y <= $max; $y++){
			my $cubeSum = $x**2 + $y**2;
			my $cubeSumSqrt = sqrt($cubeSum);
			if (isInt($cubeSumSqrt)){
				push(@pairs, $x . "-" . $y);
			}
		}
	}
}

sub findCubesWithIntegerShortestPath(){
	my $max = $_[0];
	my @result = ();
	for my $pair(@pairs){
		my @xy = split("-", $pair);
		my $x = @xy[0];
		my $y = @xy[1];
		
		#print "processing $pair = $x,$y\n";
		
		if ($x > $max && $y > $max){
			#print "skipping\n";
			next;
		}
		
		#print "processing $pair = $x,$y\n";
		
		# we are looking for all possible combinations of edges of the kuboid where
		# either the sum of two edges is $x and the other edge is $y or the other way around
		# and one of the edges has value $max
		
		my @possibleSolutions = ();
		if ($x == $max){
			my $width = $x;
			# add all possible values of b and c for which y = b + c
			for(my $height = 1; $height < $y; $height ++){
				my $depth = $y - $height;
				my $resultString = createResultString($width, $height, $depth);
				push(@possibleSolutions, $resultString);
			}
		}
		
		if ($y == $max){
			my $width = $y;
			# add all possible values of b and c for which y = b + c
			for(my $height = 1; $height < $x; $height ++){
				my $depth = $x - $height;
				my $resultString = createResultString($width, $height, $depth);
				push(@possibleSolutions, $resultString);
			}
		}
		
		if ($y > $max){
			my $width = $max;
			my $height = $y - $width;
			my $depth = $x;
			my $resultString = createResultString($width, $height, $depth);
			push(@possibleSolutions, $resultString);
		}
		
		if ($x > $max){
			my $width = $max;
			my $height = $y - $width;
			my $depth = $y;
			my $resultString = createResultString($width, $height, $depth);
			push(@possibleSolutions, $resultString);
		}

		my $expectedShortestPath = sqrt($x ** 2 + $y ** 2);
		for my $possibleSolution(@possibleSolutions){
			if ($possibleSolution ~~ @result){
				# print "skipping previously processed $possibleSolution\n";
			} else {
				my @values = split(" x ", $possibleSolution);
				my $shortestPath = calculateShortestPath($values[0], $values[1], $values[2]);
				if ($shortestPath != $expectedShortestPath){
					# print "skipping non-shortest path $possibleSolution\n";
				} else {
					#print "adding $possibleSolution\n";
					push(@result, $possibleSolution);
				}
			}
	}
	}
	
	return scalar @result;
}

sub createResultString(){
	my @sorted = sort @_;
	return "" . $sorted[0] . " x " . $sorted[1] . " x " . $sorted[2];
}

sub isInt(){
	return index($_[0], ".") == -1;
}

sub calculateShortestPath(){
	my $width = $_[0];
	my $depth = $_[1];
	my $height = $_[2];
	
	my $bottomFirstShortestPath = sqrt($width**2 + ($depth + $height)**2);
	my $frontFirstShortestPath = sqrt($height**2 + ($depth + $width)**2);
	my $sideFirstShortestPath = sqrt($depth**2 + ($height + $width)**2);
	
	my $result = $bottomFirstShortestPath;
	if ($frontFirstShortestPath < $result){
		$result = $frontFirstShortestPath;
	}
	if ($sideFirstShortestPath < $result){
		$result = $sideFirstShortestPath;
	}
	
	return $result;
}