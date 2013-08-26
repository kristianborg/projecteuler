my $maxGridSize = 20;
for (my $i = 1; $i <= $maxGridSize; $i++){
	my $x = 0;
	my $y = 0;
	my $numMoves = 0;
	$numMoves = getNumMoves($x, $y, $i);
	print "numMoves for grid size $i: $numMoves\n";
}

sub getNumMoves {
	my $x = $_[0];
	my $y = $_[1];
	my $gridSize = $_[2];
	
	my $numMoves = 0;
	if ($x < $gridSize) {$numMoves++};
	if ($y < $gridSize) {$numMoves++};
	if ($numMoves == 2){ #actually can only be one; we never move right and down at the same time
		$numMoves = getNumMoves($x + 1, $y, $gridSize) + getNumMoves($x, $y + 1, $gridSize);
	}  else {
		#print "stuck at [$x, $y]\n";
	}
	#print "moves at [$x, $y]: $numMoves\n";
	
	return $numMoves;
}