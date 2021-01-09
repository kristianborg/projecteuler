use strict;
use POSIX;

my $max = 50;
my @positions = ();
for (my $x = 0; $x <= $max; $x++){
	for (my $y = 0; $y <= $max; $y++){
		push(@positions, [$x, $y]);
	}
}

my @position1 = (0, 0);
my $numResults = 0;
my $numPositions = scalar @positions;
for (my $i = 1; $i < scalar @positions; $i++){
	print "checking position [$i/$numPositions]\n";
	my @position2 = @{$positions[$i]};
	for (my $j = $i + 1; $j < scalar @positions; $j++){
		my @position3 = @{$positions[$j]};
		
		my @vector1 = ($position2[0] -  $position3[0], $position2[1] -  $position3[1])	;
		my @vector2 = @position2;
		my @vector3 = @position3;
		if (is90Degrees(@vector1, @vector2) || 
			is90Degrees(@vector2, @vector3) || 
			is90Degrees(@vector3, @vector1)){
			
			$numResults++;
		}
	}
}
print "result: $numResults\n";

sub is90Degrees(){
	my $u1 = $_[0];
	my $u2 = $_[1];
	my $v1 = $_[2];
	my $v2 = $_[3];

	my $dotProduct = $u1 * $v1 + $u2 * $v2;
	return $dotProduct == 0;
}