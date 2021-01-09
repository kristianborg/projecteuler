use POSIX;
use strict;

my @targetStrings = ([0,1], [0,4], [0,9], [1,6], [2,5], [3,6], [4,9], [6,4], [8,1]);
my @diceValues = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
my $diceSides = 6;
my @dices = getPossibleDices($diceSides, 0);
print "found " . scalar @dices. " possible dices\n";
my $numSolutions = 0;
for (my $i = 0; $i < scalar @dices; $i++){
	my @dice1 = getExtendedDice($dices[$i]);
	for (my $j = $i; $j < scalar @dices; $j++){
		my @dice2 = getExtendedDice($dices[$j]);
		if (isSolution(\@dice1, \@dice2)){
			print "match: " . $dices[$i] . " - " . $dices[$j] . "\n";
			$numSolutions++;
		}
	}
}
print "total solutions: $numSolutions\n";

sub getExtendedDice(){
	my $diceString = $_[0];
	my @dice = split ",", $diceString;
	
	my $hasSix = 6 ~~ @dice;
	my $hasNine = 9 ~~ @dice;
	if ($hasSix && !$hasNine){
		push(@dice, 9);
	}
	if ($hasNine && !$hasSix){
		push(@dice, 6);
	}
	
	return @dice;
}

sub getPossibleDices(){
	my $sidesLeft = $_[0];
	my $minDiceValue = $_[1];
	if ($sidesLeft == 0){
		return ("");
	}
	
	my @result = ();
	for (my $i = 0; $i < scalar @diceValues; $i++){
		my $diceValue = $diceValues[$i];
		if ($diceValue >= $minDiceValue){
			my @subResults = getPossibleDices($sidesLeft - 1, $diceValue + 1);
			foreach my $subResult (@subResults){
				push(@result, $diceValue . "," . $subResult);
			}
		}
	}
	return @result;
}

sub isSolution(){
	my @dice1 = @{$_[0]};
	my @dice2 = @{$_[1]};
	
	for(my $x = 0; $x < scalar @targetStrings; $x++){
		my $val1 = $targetStrings[$x][0];
		my $val2 = $targetStrings[$x][1];
		
		if ($val1 ~~ @dice1 && $val2 ~~ @dice2){
			#match
		} elsif ($val2 ~~ @dice1 && $val1 ~~ @dice2){
			#match
		} else {
			return 0;
		}
	}
	
	return 1;
}