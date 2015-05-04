use POSIX;
use strict;

findNearestSolution(2000000);

sub findNearestSolution(){
	my $targetNumRectangles = $_[0];
	my $resultWidth = 0;
	my $resultHeight = 0;
	my $resultNumRectangles = 0;
	my $resultOffsetFromTarget = $targetNumRectangles;
	my $done = 0;
	for(my $width = 1; $width < $targetNumRectangles; $width++){
		if ($done){
			last;
		}
	
		for(my $height = $width; $height < $targetNumRectangles; $height++){
			my $numRectangles = countNumbRectangles($width, $height);
			my $offsetFromTarget = abs($targetNumRectangles - $numRectangles);
			
			if ($offsetFromTarget < $resultOffsetFromTarget){
				$resultWidth = $width;
				$resultHeight = $height;
				$resultNumRectangles = $numRectangles;
				$resultOffsetFromTarget = $offsetFromTarget;
			}
			
			if ($numRectangles >= $targetNumRectangles){
			
				if ($width == $height){
					# if we already exceed the target with the very first attempt for this width we can stop looking
					$done = 1;
				}
				last;
			}
		}
	}
	print "Rectangle of $resultWidth x $resultHeight has $resultNumRectangles subrectangles, which is $resultOffsetFromTarget from target result of $targetNumRectangles\n";
	my $resultArea = $resultWidth * $resultHeight;
	print "The eare of the resulting square is $resultArea\n";
}

sub countNumbRectangles(){
	my $width = $_[0];
	my $height = $_[1];
	my $result = 0;
	#print "processing $width x $height rectangle\n";
	for (my $subWidth = 1; $subWidth <= $width; $subWidth++){
		my $horizontalPossibilities = $width + 1 - $subWidth;
		for(my $subHeight = 1; $subHeight <= $height; $subHeight++){
			my $verticalPossibilities = $height + 1 - $subHeight;
			my $numRectangles = $horizontalPossibilities * $verticalPossibilities;
			#print "Possible number of rectangles of $subWidth x $subHeight: $numRectangles\n";
			$result += $numRectangles;
		}
	}
	print "result for $width x $height rectangle: $result\n";
	return $result;
	
}