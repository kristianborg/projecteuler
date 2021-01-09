use strict;
use POSIX;
 
my $modPow = modPow(2, 7830457, 10000000000);
my $result = (($modPow * 28433) + 1) % 10000000000;
print "result: $result\n";
 
sub modPow(){
	my $base = $_[0];
	my $pow = $_[1];
	my $mod = $_[2];
               
	my $result = 1;
	for (my $i = 0; $i < $pow; $i++){
		$result *= $base;
		$result %= $mod;
	}
 
	print "$base ^ $pow % $mod = $result\n";
	return $result;
}
