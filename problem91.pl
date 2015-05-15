use strict;
use POSIX;

my $max = 50;
my $numResults=0;
for (my $x1 = 0; $x1 <= $max; $x1++){
	print "processing $x1\n";
	for (my $y1 = 0; $y1 <= $max; $y1++){
		for (my $x2 = 0; $x2 <= $max; $x2++){
			for (my $y2 = 0; $y2 <= $max; $y2++){
				my $x3 = $x1 - $x2;
				my $y3 = $y1 - $y2;
				if (is90Degrees($x3, $y3, $x1, $y1)){
					$numResults++;
				} elsif (is90Degrees($x3, $y3, $x2, $y2)){
					$numResults++;
				} elsif (is90Degrees($x1, $y1, $x2, $y2)){
					$numResults++;
				}
			}
		}
	}
}
$numResults = $numResults / 2;
print "numResults: $numResults\n";

#source: http://www.wikihow.com/Find-the-Angle-Between-Two-Vectors
sub is90Degrees(){
	my $u1 = $_[0];
	my $u2 = $_[1];
	my $v1 = $_[2];
	my $v2 = $_[3];
	
	my $dotProduct = $u1 * $v1 + $u2 * $v2;
	my $lengthU = sqrt($u1 ** 2 + $u2 ** 2);
	my $lengthV = sqrt($v1 ** 2 + $v2 ** 2);
	
	if ($lengthU == 0 || $lengthV == 0){
		return 0;
	}
	
	# dotproct = 0, means angle of 90 degrees
	return $dotProduct == 0;
}
