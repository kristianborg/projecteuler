use bigint;
use Math::BigInt;

my $min = 2;
my $max = 100;
my $result = 0;
%sequence = {};
for (my $a = $min; $a <= $max; $a++){
	print "processing $a\n";
	for (my $b = $min; $b <= $max; $b++){
		$pow = $a ** $b;
		if ($sequence{$pow} == 1){
			#print "skipping previously seen $pow\n";
		} else {
			print "adding: $a ^ $b\n";
			$sequence{$pow} = 1;
			$result++;
		}
	}
}
print "result size: $result\n";