my $xWins = 0;
my $yWins = 0;
my $maxGames = 10_000_000_000;
my $updateInterval = 10_000_000;
for (my $i = 0; $i < $maxGames; $i++){
	play();
	if ($i % $updateInterval == 0){
		print "$i: xWins: $xWins, yWins: $yWins, probability: ", $yWins * 100 / ($xWins + $yWins), "\n";
	}
}

sub play(){
	my $s = 0;
	my $xRand = 0;
	while ($s < 1){
		$xRand = rand();
		$s += $xRand;
	}
	
	my $yRand = 0;
	while($s < 2){
		$yRand = rand();
		$s += $yRand;
	}
	
	if ($xRand > $yRand){
		$xWins++;
	} else {
		$yWins++;
	}
}