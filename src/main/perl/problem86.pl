use POSIX;
use strict;

my $max = 10;

my $result = 0;
for(my $width = 1; $width <= $max; $width++){
	for(my $depth = $width; $depth <= $max; $depth++){
		for(my $height = $depth; $height <= $max; $height++){
			my $shortestPath = calculateShortestPath($width, $depth, $height);
			if (isInt($shortestPath)){
				print "shortest path for cuboid $width x $depth x $height: $shortestPath\n";
				$result++;
			}
		}
	}
}
print "num kuboids with integer lenth shortest path for max size $max: $result\n";
#calculateShortestPath(6, 5, 3);

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

sub isInt(){
	return index($_[0], ".") == -1;
}