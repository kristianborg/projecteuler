@numbers = (1..100);
$sumSquares = 0;
foreach(@numbers){
	$sumSquares += $_ ** 2;
}
print "sumSquares: $sumSquares\n";

$sum = 0;
foreach(@numbers){
	$sum += $_;
}
print "sum: $sum\n";

$squareSum = $sum ** 2;
print "squareSum: $squareSum\n";

$squareDiff = $squareSum - $sumSquares;
print "squareDiff: $squareDiff\n";