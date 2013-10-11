use POSIX;
use strict;

my $max = 10000000;
print "calucalting primes...\n";
my @primes = getPrimes($max);

print "calucalting phi's...\n";
my @phis = ();
getPhis(1, 1, 0);

print "processing phi's...\n";
my $result = 0;
my $minNoverPhi = 999;
for(my $i = 2; $i <= $max; $i++){
	my $phi = $phis[$i];
	if(isPermutation($i, $phi)){
		my $nOverPhi = $i / $phi;
		if ($nOverPhi < $minNoverPhi){
			$result = $i;
			$minNoverPhi = $nOverPhi;
			print "phi($i) = $phi (n/phi = $nOverPhi)\n";
		}
	}
}
print "result: $result\n";

sub getPhis(){
	my $n = $_[0];
	my $subPhi = $_[1];
	my $primePointer = $_[2];
	for (my $i = $primePointer; $i < @primes; $i++){
		my $prime = $primes[$i];
		my $newN = $n * $prime;
		if ($newN > $max){
			last;
		}
		
		my $newSubPhi = $subPhi;
		if ($i != $primePointer || $n == 1){
			$newSubPhi *= (1 - (1 / $prime));
		}
		
		my $newPhi = $newN * $newSubPhi;
		$phis[$newN] = $newN * $newSubPhi;
		getPhis($newN, $newSubPhi, $i);
	}
}

sub isPermutation(){
	return join("", sort(split("", $_[0]))) eq join("", sort(split("", $_[1])));
}

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