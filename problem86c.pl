use POSIX;
use strict;

my $guessedMax = 2000;
my $targetNumPaths = 1000000;
my @numIntPathsPerLength = ();
my $before = time();
populate($guessedMax * 2);

my $numPaths = 0;
for(my $i = 1; $i <= $guessedMax; $i++){
	$numPaths += $numIntPathsPerLength[$i];
	if ($numPaths >= $targetNumPaths){
		print "number of shortest paths exceeds $targetNumPaths for max kuboid edge size = $i\n";
		last;
	}
}

my $after = time();
my $time = $after - $before;
print "took $time seconds\n";

sub populate(){
	my $max = $_[0];
	for (my $x = 1; $x < $max; $x++){
		my $xSquare = $x ** 2;
		for (my $y = $x; $y < $max; $y++){
			my $ySquare = $y ** 2;
			my $sum = $xSquare + $ySquare;
			my $z = sqrt($sum);
			
			if (isInt($z)){
				# now we know sqrt(x^2 + y^2) is an integer. Let's check all possible combinations of kuboids that match this formula
				my $a = $x;
				for (my $b = 1; $b <= $y / 2; $b++){
					my $c = $y - $b;
					my $shortestPath = calculateShortestPath($a, $b, $c);
					if ($shortestPath == $z){
						my $longestSide = getMax($a, $b, $c);
						$numIntPathsPerLength[$longestSide]++;
					}
				}
				
				my $d = $y;
				for (my $e = 1; $e <= $x/2; $e++){
					my $f = $x - $e;
					my $shortestPath = calculateShortestPath($d, $e, $f);
					if ($shortestPath == $z){
						my $longestSide = getMax($d, $e, $f);
						$numIntPathsPerLength[$longestSide]++;
					}
				}
			}
		}
	}
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

sub getMax(){
	my @sorted = sort {$a <=> $b} @_;
	return $sorted[2];
}