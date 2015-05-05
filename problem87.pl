use POSIX;
use strict;

my $max = 50000000;
my $maxPow2Prime = sqrt($max);
my $maxPow3Prime = $max ** (1/3);
my $maxPow4Prime = $max ** (1/4);

my @primes = getPrimes($maxPow2Prime);
my @result = ();
for my $pow2Prime(@primes){
	for my $pow3Prime(@primes){
		if ($pow3Prime > $maxPow3Prime){
			last;
		}
		for my $pow4Prime(@primes){
			if ($pow4Prime > $maxPow4Prime){
				last;
			}
			
			my $sum = $pow2Prime ** 2 + $pow3Prime ** 3 + $pow4Prime ** 4;
			if ($sum <= $max){
				$result[$sum] = 1;
				#print "$sum = $pow2Prime^2 + $pow3Prime^3 + $pow4Prime^4\n";
			}
		}
	}
}

my $num = 0;
for my $number(@result){
	if ($number == 1){
		$num++;
	}
}
print "result: $num\n";

sub getPrimes(){
	my $max = $_[0];
	my @numbers = (0, 0);
	for(my $i = 2; $i <= $max; $i++){
		$numbers[$i] = 1;
	}
	
	for(my $i = 2; $i <= ceil($max/2); $i++){
		if (!$numbers[$i]){
			next;
		}
		
		push(@primes, $i);
		for(my $j = $i * 2; $j <= $max; $j += $i){
			$numbers[$j] = 0;
		}
	}
	
	my @primes = ();
	for(my $i = 2; $i <= $max; $i++){
		if($numbers[$i]){
			push(@primes, $i);
		}
	}
	
	return @primes;
}