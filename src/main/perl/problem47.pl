use POSIX;
use List::MoreUtils qw/ uniq /;

my @primes = (2);
my $i = 3;
my $targetNumDivisors = 4;
my $targetLength = 4;
my $length = 0;
while(1){
	if (isPrime($i)){
		push(@primes, $i);
	}
	
	my @divisors = getPrimeDivisors($i);
	my @uniqDivisors = uniq(@divisors);
	print "divisors for $i: @divisors; (uniq: @uniqDivisors)\n";
	if (scalar @uniqDivisors == $targetNumDivisors){
		$length++;
	} else {
		$length = 0;
	}
	
	if ($length == $targetLength){
		print "done\n";
		exit;
	}
	
	$i++;
}

sub getPrimeDivisors(){
	my $n = $_[0];
	@divisors = ();
	foreach(@primes){
		while($n % $_ == 0){
			push(@divisors, $_);
			$n /= $_;
		}
		if ($n == 1){
			last;
		}
	}
	return @divisors;
}

sub isPrime(){
	my $n = $_[0];
	my $max = ceil(sqrt($n));
	my $result = 1;
	foreach(@primes){
		if ($_ > $max){
			last;
		}
		if ($n % $_ == 0){
			$result = 0;
			last;
		}
	}
	return $result;
}