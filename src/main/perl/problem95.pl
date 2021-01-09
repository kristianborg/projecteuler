use strict;
use POSIX;
 
my $max = 1000000;
my @divisorsums = ();
populateDivisorSum($max);
 
my @divisorsumchains = ();
populateDivisorSumChains($max);
 
my $largestChain = 0;
for (my $i = 1; $i <= $max; $i++){
	my $chainLength = $divisorsumchains[$i];
	if ($chainLength >= $largestChain){
		$largestChain = $chainLength;
		print "$i has chain " . $divisorsumchains[$i] . "\n";
	}
}
 
print "largest chain has length $largestChain: [ ";
for (my $i = 1; $i <= $max; $i++){
	if ($divisorsumchains[$i] == $largestChain){
		print "$i ";
	}
}
print "]\n";
 
 
sub populateDivisorSum(){
	my $max = $_[0];
	for (my $i = 1; $i <= $max; $i++){
		my $divisorsum = getDivisorSum($i);
		if ($divisorsum <= $max){
			$divisorsums[$i]=$divisorsum;
		}
	}
}
 
sub populateDivisorSumChains(){
	my $max = $_[0];
	for (my $i = 1; $i <= $max; $i++){
		if (!$divisorsumchains[$i]){
			populateDivisorSumChain($i);
		}
	}
}
 
sub populateDivisorSumChain(){
	my $startingPoint = $_[0];
	my $current = $startingPoint;
	my @seen = ($startingPoint);
	while (1){
		my $next = $divisorsums[$current];
		if ($next ~~ @seen){
			my $loopStart = $next;
			# we found a loop;
			#print "found a loop. Startingpoint: $startingPoint; loop point: $loopStart\n";
		               
 
			markNonLoop($startingPoint, $loopStart);
			my $loopLength = getLoopLength($loopStart);
			#print "loop length: $loopLength\n";
			markLoop($loopStart, $loopLength);
			return;
		} else {
			$current = $next;
			push(@seen, $current);
		}
	}
}
 
sub markLoop(){
	my $loopStart = $_[0];
	my $loopLength = $_[1];
	$divisorsumchains[$loopStart] = $loopLength;
	#print "marking $loopStart with loopLength $loopLength\n";
	my $current = $divisorsums[$loopStart];
	while ($current != $loopStart){
		#print "marking $current with loopLength $loopLength\n";
		$divisorsumchains[$current] = $loopLength;
		$current = $divisorsums[$current];
	}
}
 
sub markNonLoop(){
	my $nonLoopStart = $_[0];
	my $nonLoopEnd = $_[1];
	my $current = $nonLoopStart;
	while($current != $nonLoopEnd && $divisorsumchains[$current] != -1){
		#print "marking non-loop: $current\n";
		$divisorsumchains[$current] = -1;
		$current = $divisorsums[$current];
	}
}
 
sub getLoopLength(){
	my $loopStart = $_[0];
	my $result = 1;
	my $current = $divisorsums[$loopStart];
	while ($current != $loopStart){
		$result++;
		$current = $divisorsums[$current];	         
	}
	return $result;
}
 
sub getDivisorSum(){
	my $num = $_[0];
	my $result = 1;
	for (my $i = 2; $i <= sqrt($num); $i++){
		if ($num % $i == 0){
			$result += $i;
			$result += ($num / $i);
		}
	}
 
	#print "divisor sum of $num = $result\n";
	return $result;
}
 
sub getDivisors(){
	my $num = $_[0];
	my @result = (1);
	for (my $i = 2; $i <= sqrt($num); $i++){
		if ($num % $i == 0){
			push(@result, $i);
			push(@result, $num / $i);
		}
	}
 
	return sort {$a <=> $b} @result;
}
