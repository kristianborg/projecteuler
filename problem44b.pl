use Time::HiRes qw(time);
use POSIX;

my $timeStep = 10000;
my $max = 10000000;
my $i = 1;
my $cacheSize = 1000;
my $previousTime = 0;
my $currentTime = time();
my @cache = ();
while(1){
	if ($i % $timeStep == 0){
		$previousTime = $currentTime;
		$currentTime = time();
		my $time = $currentTime - $previousTime;
		my $eta = ($max - $i) / $timeStep * $time;
		$time = substr($time, 0, index($time, "."));
		$eta = substr($eta, 0, index($eta, "."));
		print "processing $i; current step took $time seconds; ETA: $eta seconds\n";
	}
	my $pent = getPentagonal($i);
	foreach(@cache){
		my $prevPent = $_;
		my $sum = $pent + $prevPent;
		my $diff = $pent - $prevPent;
		
		if (isPentagonal($sum) && isPentagonal($diff)){
			print "$i: sum and diff  $pent and $prevPent: $sum and $diff is pentagonal\n";
			exit;
		}
	}
	
	$cache[($i - 1) % $cacheSize] = $pent;
	$i++;
	
	if ($i > $max){
		last;
	}
}


sub getPentagonal(){
	return $_[0] * (3 * $_[0] - 1) / 2;
}

sub isPentagonal(){
	my $i = $_[0] * 24 + 1;
	my $sqrt = sqrt($i);
	my $result =  floor($sqrt) == $sqrt && $sqrt % 6 == 5;
	#print "pentagonal check for $_[0]: $result\n";
	return $result;
}
